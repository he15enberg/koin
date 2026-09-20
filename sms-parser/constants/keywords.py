"""
Keywords for transaction type detection and merchant extraction.
Mirrors SmsParserHelper from sms_parser.dart and merchant list from merchant_name.dart
"""

from typing import List

# Keywords indicating a debit transaction
DEBIT_KEYWORDS: List[str] = [
    "debited",
    "debit",
    "sent",
    "withdrawn",
    "purchase",
    "spent",
    "paid",
    "transferred",
]

# Keywords indicating a credit transaction
CREDIT_TYPE_KEYWORDS: List[str] = [
    "credited",
    "credit",
    "received",
    "deposit",
    "added",
]

# Bank shorthand for Debit/Credit (e.g. "Rs.18.00 Dr. from A/C ... Cr. to ...").
# Kept out of the plain substring lists above because a bare "dr"/"cr" would
# false-positive on ordinary words (e.g. "address" contains "dr"); these are
# matched with a word-boundary regex instead, in sms_parser.py.
DEBIT_SHORTHAND = "dr."
CREDIT_SHORTHAND = "cr."

# Sender codes that are structurally non-transactional (verified against
# real data: HDFCBN carries only credit-card/loan marketing, RBISAY only
# carries RBI's public fraud-awareness broadcasts) -- never a real txn.
NON_TRANSACTIONAL_SENDER_CODES: List[str] = [
    "HDFCBN",
    "RBISAY",
]

# Common merchant names for direct matching
# Mirrors _extractFromCommonMerchants in merchant_name.dart
COMMON_MERCHANTS: List[str] = [
    "ZOMATO",
    "SWIGGY",
    "UBER",
    "OLA",
    "AMAZON",
    "FLIPKART",
    "MYNTRA",
    "GPAY",
    "PHONEPE",
    "PAYTM",
    "NETFLIX",
    "HOTSTAR",
    "SPOTIFY",
    "DOMINOS",
    "PIZZA HUT",
    "KFC",
    "MCDONALDS",
    "STARBUCKS",
    "RELIANCE",
    "DMART",
    "BIG BAZAAR",
    "AIRTEL",
    "JIO",
    "VI",
]
