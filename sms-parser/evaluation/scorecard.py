"""
Run the sms_parser engine (the real, unmodified package) against a
dataframe of real SMS and report stage-by-stage diagnostics: bank
identification, amount/type extraction, merchant quality, and category
coverage.

No ground truth is needed here -- these are aggregate rates, useful for
spotting where the parser is bleeding data and for measuring the effect
of a tuning change (run before/after, diff the numbers).
"""
import importlib
import sys
from collections import Counter
from pathlib import Path

import pandas as pd

# sms-parser/evaluation/scorecard.py -> parents[1] is the koin repo root
# (parent of the sms-parser folder), which is what needs to be on sys.path
# for `import sms-parser` (hyphenated dir, loaded via importlib) to work.
REPO_ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(REPO_ROOT))
_sms_parser_pkg = importlib.import_module("sms-parser")
SmsParser = _sms_parser_pkg.SmsParser
BankDirectory = _sms_parser_pkg.BankDirectory


def score(df: pd.DataFrame) -> dict:
    total = len(df)
    parsed = 0
    dropped = 0
    type_counts: Counter = Counter()
    merchant_unknown = 0
    category_none = 0
    is_transaction = 0  # parsed AND type resolved to debit/credit
    bank_id_correct = 0
    per_bank: dict = {}

    for _, row in df.iterrows():
        body = row["SMS Body"]
        sender = row["Sender"]
        expected_bank_code = str(row["Bank Code"]).upper()

        stats = per_bank.setdefault(expected_bank_code, Counter())
        stats["total"] += 1

        # Stage 1: does our BankDirectory resolve the SAME bank code the
        # export's own extraction already found for this sender?
        matched_code = BankDirectory.find_bank_code(sender)
        if matched_code is not None and matched_code.upper() == expected_bank_code:
            bank_id_correct += 1
            stats["bank_id_correct"] += 1

        result = SmsParser.parse_transaction(body, sender)
        if result is None:
            dropped += 1
            stats["dropped"] += 1
            continue

        parsed += 1
        stats["parsed"] += 1
        type_counts[result.transaction_type.value] += 1
        stats[f"type_{result.transaction_type.value}"] += 1

        if result.merchant_name == "Unknown":
            merchant_unknown += 1
            stats["merchant_unknown"] += 1

        if result.category is None:
            category_none += 1
            stats["category_none"] += 1
        else:
            stats["category_assigned"] += 1

        if result.transaction_type.value in ("debit", "credit"):
            is_transaction += 1
            stats["is_transaction"] += 1

    def pct(n, d):
        return round(n / d * 100, 1) if d else 0.0

    return {
        "total_messages": total,
        "bank_id_correct": bank_id_correct,
        "bank_id_correct_pct": pct(bank_id_correct, total),
        "parsed": parsed,
        "parsed_pct": pct(parsed, total),
        "dropped": dropped,
        "dropped_pct": pct(dropped, total),
        "type_distribution": dict(type_counts),
        "final_transactions": is_transaction,
        "final_transactions_pct": pct(is_transaction, total),
        "merchant_unknown_of_parsed": merchant_unknown,
        "merchant_unknown_pct_of_parsed": pct(merchant_unknown, parsed),
        "category_none_of_parsed": category_none,
        "category_none_pct_of_parsed": pct(category_none, parsed),
        "per_bank_code": {k: dict(v) for k, v in per_bank.items()},
    }


def print_report(sc: dict) -> None:
    print("=" * 78)
    print("SMS PARSER SCORECARD")
    print("=" * 78)
    print(f"Total messages evaluated:              {sc['total_messages']}")
    print(f"Bank correctly identified (Stage 1):   {sc['bank_id_correct']} ({sc['bank_id_correct_pct']}%)")
    print(f"Parsed (amount+fields found):           {sc['parsed']} ({sc['parsed_pct']}%)")
    print(f"Dropped (no valid amount/invalid):      {sc['dropped']} ({sc['dropped_pct']}%)")
    print(f"Type distribution (of parsed):          {sc['type_distribution']}")
    print(f"Final transactions (debit/credit only): {sc['final_transactions']} ({sc['final_transactions_pct']}%)")
    print(f"Merchant=Unknown (of parsed):            {sc['merchant_unknown_of_parsed']} ({sc['merchant_unknown_pct_of_parsed']}%)")
    print(f"Category=None (of parsed):               {sc['category_none_of_parsed']} ({sc['category_none_pct_of_parsed']}%)")
    print()
    print("-" * 78)
    header = f"{'Bank Code':<12}{'Total':>7}{'BankOK':>8}{'Parsed':>8}{'Dropped':>9}{'Txn':>6}{'CatNone':>9}"
    print(header)
    print("-" * 78)
    rows = sorted(sc["per_bank_code"].items(), key=lambda kv: -kv[1].get("total", 0))
    for code, stats in rows:
        print(
            f"{code:<12}{stats.get('total', 0):>7}{stats.get('bank_id_correct', 0):>8}"
            f"{stats.get('parsed', 0):>8}{stats.get('dropped', 0):>9}"
            f"{stats.get('is_transaction', 0):>6}{stats.get('category_none', 0):>9}"
        )
    print("-" * 78)
