"""
CLI entrypoint: load the real SMS exports, drop the excluded (non-transaction)
bank codes, run the scorecard against the sms_parser engine, and persist
results for tracking over time.

Usage:
    python run_eval.py
    python run_eval.py --input a.xlsx b.xlsx --exclude SBIUPI SBIBNK
"""
import argparse
import json
from pathlib import Path

import pandas as pd

from load_dataset import (
    DEFAULT_EXCLUDED_BANK_CODES,
    DEFAULT_INPUT_FILES,
    load_and_filter,
    load_raw,
)
from scorecard import SmsParser, print_report, score


def build_final_transaction_dataset(df: pd.DataFrame) -> pd.DataFrame:
    """Re-parse the filtered dataframe and keep only rows the engine
    resolved to an actual debit/credit transaction (its current
    definition of a 'real' transaction SMS)."""
    rows = []
    for _, row in df.iterrows():
        result = SmsParser.parse_transaction(row["SMS Body"], row["Sender"])
        if result is not None and result.transaction_type.value in ("debit", "credit"):
            rows.append(
                {
                    "sms_id": row.get("SMS ID"),
                    "date_time": str(row.get("Date & Time")),
                    "sender": row["Sender"],
                    "bank_code_raw": row["Bank Code"],
                    "bank_code_matched": result.bank_code,
                    "bank_name": result.bank_name,
                    "amount": result.amount,
                    "type": result.transaction_type.value,
                    "merchant": result.merchant_name,
                    "category": result.category,
                    "account_last4": result.account_last_four_digits,
                    "reference_number": result.reference_number,
                    "sms_body": row["SMS Body"],
                }
            )
    return pd.DataFrame(rows)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", nargs="+", default=DEFAULT_INPUT_FILES)
    parser.add_argument(
        "--exclude", nargs="*", default=sorted(DEFAULT_EXCLUDED_BANK_CODES)
    )
    parser.add_argument(
        "--out-dir", default=str(Path(__file__).parent / "output")
    )
    args = parser.parse_args()

    raw_df = load_raw(args.input)
    filtered_df = load_and_filter(args.input, args.exclude)

    print(f"Raw messages loaded:                {len(raw_df)}")
    print(f"Excluded bank codes {args.exclude}")
    print(f"  -> rows excluded:                 {len(raw_df) - len(filtered_df)}")
    print(f"Remaining messages for evaluation:  {len(filtered_df)}")
    print()

    result = score(filtered_df)
    print_report(result)

    out_dir = Path(args.out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)

    scorecard_path = out_dir / "scorecard.json"
    scorecard_path.write_text(json.dumps(result, indent=2))
    print(f"\nScorecard written to: {scorecard_path}")

    txn_df = build_final_transaction_dataset(filtered_df)
    txn_csv_path = out_dir / "final_transactions.csv"
    txn_df.to_csv(txn_csv_path, index=False)
    print(f"Final transaction dataset ({len(txn_df)} rows) written to: {txn_csv_path}")


if __name__ == "__main__":
    main()
