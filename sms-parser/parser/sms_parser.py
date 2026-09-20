"""
SMS Parser - Main parsing logic.

Mirrors SmsParser and SmsParserHelper from sms_parser.dart
"""

from datetime import datetime
from typing import Optional

import re

from ..models.transaction import Transaction, TransactionType
from ..constants.banks import BankDirectory
from ..constants.keywords import (
    DEBIT_KEYWORDS,
    CREDIT_TYPE_KEYWORDS,
    NON_TRANSACTIONAL_SENDER_CODES,
)
from ..patterns.regex_patterns import (
    AMOUNT_PATTERN,
    ACCOUNT_PATTERN,
    REFERENCE_PATTERN,
    PENDING_ACTION_PATTERN,
    PROMOTIONAL_CONTENT_PATTERN,
)

_DEBIT_SHORTHAND_PATTERN = re.compile(r'\bdr\.', re.IGNORECASE)
_CREDIT_SHORTHAND_PATTERN = re.compile(r'\bcr\.', re.IGNORECASE)
from .merchant_extractor import MerchantExtractor
from .category_classifier import CategoryClassifier


class SmsParser:
    """
    Main SMS parser class.
    Mirrors SmsParser from Dart implementation.
    """

    @classmethod
    def parse_transaction(
        cls,
        body: str,
        sender: str,
        date: Optional[datetime] = None,
    ) -> Optional[Transaction]:
        """
        Parse an SMS message and extract transaction details.

        Args:
            body: The SMS message body
            sender: The SMS sender (bank code)
            date: The SMS date/time (defaults to now)

        Returns:
            Transaction object if parsing successful, None otherwise
        """
        try:
            if not body or not sender:
                return None

            if date is None:
                date = datetime.now()

            # Known non-transactional channels (marketing / public-awareness
            # broadcasts) -- never a real transaction, regardless of wording.
            if any(code in sender.upper() for code in NON_TRANSACTIONAL_SENDER_CODES):
                return None

            # A pending money *request* or a future-tense "will be
            # debited/credited" describes money that hasn't moved yet.
            if PENDING_ACTION_PATTERN.search(body):
                return None

            # Marketing SMS that mentions an amount (credit limit, voucher,
            # loan offer) but describes no real transaction.
            if PROMOTIONAL_CONTENT_PATTERN.search(body):
                return None

            # Find matching bank code
            bank_codes = BankDirectory.get_bank_codes()
            bank_code = None

            for code in bank_codes:
                if code.upper() in sender.upper():
                    bank_code = code
                    break

            if bank_code is None:
                bank_code = sender

            # Get bank info
            bank_info = BankDirectory.get_bank_info(bank_code)
            bank_name = bank_info.name if bank_info else bank_code
            bank_photo = bank_info.image if bank_info else ""

            # Extract amount using regex
            amount = cls._extract_amount(body)
            if amount is None or amount <= 0:
                return None

            # Extract account last 4 digits
            account_last_four = cls._extract_account_digits(body)

            # Determine transaction type
            transaction_type = cls._get_transaction_type(body)

            # Extract merchant name
            merchant_name = MerchantExtractor.extract_merchant_name(
                body, transaction_type
            )

            # Extract reference number
            reference_number = cls._extract_reference_number(body)

            # Classify transaction category
            category = CategoryClassifier.classify_transaction(
                merchant_name, transaction_type
            )

            return Transaction(
                bank_code=bank_code,
                amount=amount,
                bank_name=bank_name,
                bank_photo=bank_photo,
                account_last_four_digits=account_last_four,
                merchant_name=merchant_name,
                date_time=date,
                reference_number=reference_number,
                transaction_type=transaction_type,
                message_address=sender,
                message_body=body,
                merchant_photo=None,
                category=category,
            )

        except Exception as e:
            print(f"Error parsing transaction: {e}")
            return None

    @staticmethod
    def _extract_amount(body: str) -> Optional[float]:
        """Extract amount from SMS body."""
        match = AMOUNT_PATTERN.search(body)
        if match:
            amount_str = match.group(1).replace(",", "")
            try:
                return float(amount_str)
            except ValueError:
                return None
        return None

    @staticmethod
    def _extract_account_digits(body: str) -> str:
        """Extract last 4 digits of account number."""
        match = ACCOUNT_PATTERN.search(body)
        if match:
            # Remove X and * characters, keep only digits
            result = match.group(0)
            return "".join(c for c in result if c.isdigit())[-4:]
        return ""

    @staticmethod
    def _get_transaction_type(body: str) -> TransactionType:
        """Determine transaction type from SMS body."""
        lower_body = body.lower()

        # Debit checked first: for a message describing money leaving one
        # account and landing in another (e.g. "Dr. from A/C X and Cr. to
        # Y"), the classification is from the account holder's own
        # perspective, i.e. a debit.
        if any(kw in lower_body for kw in DEBIT_KEYWORDS) or _DEBIT_SHORTHAND_PATTERN.search(body):
            return TransactionType.DEBIT
        elif any(kw in lower_body for kw in CREDIT_TYPE_KEYWORDS) or _CREDIT_SHORTHAND_PATTERN.search(body):
            return TransactionType.CREDIT
        else:
            return TransactionType.UNKNOWN

    @staticmethod
    def _extract_reference_number(body: str) -> str:
        """Extract transaction reference number."""
        match = REFERENCE_PATTERN.search(body)
        if match:
            # Return first non-None group
            return match.group(1) or match.group(2) or match.group(3) or ""
        return ""

    @classmethod
    def is_bank_sms(cls, sender: str) -> bool:
        """
        Check if sender is a known bank.

        Args:
            sender: The SMS sender string

        Returns:
            True if sender matches a known bank code
        """
        return BankDirectory.is_bank_sender(sender)

    @classmethod
    def parse_multiple(
        cls,
        messages: list,
    ) -> list:
        """
        Parse multiple SMS messages.

        Args:
            messages: List of dicts with 'body', 'sender', 'date' keys

        Returns:
            List of successfully parsed Transaction objects
        """
        transactions = []
        for msg in messages:
            result = cls.parse_transaction(
                body=msg.get("body", ""),
                sender=msg.get("sender", ""),
                date=msg.get("date"),
            )
            if result:
                transactions.append(result)
        return transactions
