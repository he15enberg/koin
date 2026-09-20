"""
SMS Parser - Bank Transaction SMS Parsing Library

A Python module for extracting and categorizing bank transactions from SMS messages.
Mirrors the Dart implementation from the Koin Flutter app.

Usage:
    from sms_parser import SmsParser, TransactionType

    result = SmsParser.parse_transaction(
        body="Rs.500 debited from A/c XX1234 to Zomato via UPI",
        sender="HDFCBK",
        date=datetime.now()
    )

    if result:
        print(f"Amount: {result.amount}")
        print(f"Merchant: {result.merchant_name}")
        print(f"Category: {result.category}")
"""

from .models.transaction import Transaction, TransactionType
from .parser.sms_parser import SmsParser
from .parser.merchant_extractor import MerchantExtractor
from .parser.category_classifier import CategoryClassifier
from .constants.banks import BankDirectory, BankInfo

__version__ = "1.0.0"
__all__ = [
    "SmsParser",
    "Transaction",
    "TransactionType",
    "MerchantExtractor",
    "CategoryClassifier",
    "BankDirectory",
    "BankInfo",
]
