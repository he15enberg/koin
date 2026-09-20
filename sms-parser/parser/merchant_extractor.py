"""
Merchant name extraction - mirrors merchant_name.dart

Implements 7 extraction patterns in priority order:
1. Payee pattern
2. UPI pattern
3. At/To pattern
4. Via pattern
5. Transfer pattern
6. Common merchants
7. Email pattern
"""

from typing import Optional
from ..models.transaction import TransactionType
from ..patterns.regex_patterns import (
    PAYEE_PATTERN,
    UPI_PATTERNS,
    AT_TO_PATTERN,
    VIA_PATTERN,
    TRANSFER_PATTERNS,
    EMAIL_PATTERN,
    PREFIX_PATTERN,
    SUFFIX_PATTERN,
    MULTIPLE_SPACES_PATTERN,
    TRAILING_PUNCTUATION_PATTERN,
    BANKING_TERMS_PATTERN,
)
from ..constants.keywords import COMMON_MERCHANTS

# Fragments an extractor can grab when it fires on template boilerplate
# instead of a real merchant (e.g. the old "return transaction type" UPI
# fallback used to literally name the merchant "Debit"/"Credit"). Checked
# case-insensitively before a match is accepted, so the cascade keeps
# trying later, more specific extractors instead of locking in garbage.
_GARBAGE_MERCHANT_TOKENS = {
    "debit", "credit", "ref", "rs", "inr", "dr", "cr", "unknown", "",
}


class MerchantExtractor:
    """
    Extracts merchant name from SMS message body.
    Mirrors MerchantExtractor from Dart implementation.
    """

    @classmethod
    def extract_merchant_name(
        cls,
        message_body: str,
        transaction_type: TransactionType,
    ) -> str:
        """
        Extract merchant name using multiple patterns in priority order.

        Args:
            message_body: The SMS message body
            transaction_type: The transaction type (credit/debit)

        Returns:
            Extracted merchant name or "Unknown"
        """
        body = message_body.strip()

        # Try multiple extraction patterns in order of priority
        extractors = [
            cls._extract_from_payee_pattern,
            cls._extract_from_upi_pattern,
            cls._extract_from_at_to_pattern,
            cls._extract_from_via_pattern,
            cls._extract_from_transfer_pattern,
            cls._extract_from_common_merchants,
            cls._extract_from_email_pattern,
        ]

        for extractor in extractors:
            merchant_name = extractor(body, transaction_type)
            if merchant_name and merchant_name.strip().lower() not in _GARBAGE_MERCHANT_TOKENS:
                return cls._clean_merchant_name(merchant_name)

        return "Unknown"

    @staticmethod
    def _extract_from_payee_pattern(
        body: str,
        transaction_type: TransactionType,
    ) -> str:
        """Pattern 1: Payee-based extraction (highest priority)."""
        match = PAYEE_PATTERN.search(body)
        return match.group(1).strip() if match else ""

    @staticmethod
    def _extract_from_upi_pattern(
        body: str,
        transaction_type: TransactionType,
    ) -> str:
        """Pattern 2: UPI-specific patterns."""
        for i, pattern in enumerate(UPI_PATTERNS):
            match = pattern.search(body)
            if match:
                merchant = match.group(1) or ""

                # For VPA patterns (first two), preserve the full UPI ID
                if i <= 1:
                    return merchant.strip()

                # For other UPI patterns, extract merchant part if it contains @
                if "@" in merchant:
                    merchant = merchant.split("@")[0]
                return merchant.strip()

        # No specific UPI sub-pattern matched -- let the cascade fall through
        # to the remaining extractors instead of naming the merchant after
        # the transaction type itself (that used to produce merchant names
        # like "Debit"/"Credit", which are meaningless and uncategorizable).
        return ""

    @staticmethod
    def _extract_from_at_to_pattern(
        body: str,
        transaction_type: TransactionType,
    ) -> str:
        """Pattern 3: At/To patterns."""
        match = AT_TO_PATTERN.search(body)
        return match.group(1).strip() if match else ""

    @staticmethod
    def _extract_from_via_pattern(
        body: str,
        transaction_type: TransactionType,
    ) -> str:
        """Pattern 4: Via patterns."""
        match = VIA_PATTERN.search(body)
        return match.group(1).strip() if match else ""

    @staticmethod
    def _extract_from_transfer_pattern(
        body: str,
        transaction_type: TransactionType,
    ) -> str:
        """Pattern 5: Transfer patterns."""
        for pattern in TRANSFER_PATTERNS:
            match = pattern.search(body)
            if match:
                return match.group(1).strip()
        return ""

    @staticmethod
    def _extract_from_common_merchants(
        body: str,
        transaction_type: TransactionType,
    ) -> str:
        """Pattern 6: Common merchant names (exact matches)."""
        body_upper = body.upper()
        for merchant in COMMON_MERCHANTS:
            if merchant in body_upper:
                return merchant
        return ""

    @staticmethod
    def _extract_from_email_pattern(
        body: str,
        transaction_type: TransactionType,
    ) -> str:
        """Pattern 7: Email-like patterns."""
        match = EMAIL_PATTERN.search(body)
        if match:
            email = match.group(1) or ""
            # Extract merchant name before @
            return email.split("@")[0]
        return ""

    @staticmethod
    def _clean_merchant_name(merchant_name: str) -> str:
        """Clean and normalize merchant name."""
        if not merchant_name:
            return "Unknown"

        # Remove common prefixes (MR, MS, DR, etc.)
        cleaned = PREFIX_PATTERN.sub("", merchant_name)

        # Remove common suffixes (PVT, LTD, etc.)
        cleaned = SUFFIX_PATTERN.sub("", cleaned)

        # Multiple spaces to single space
        cleaned = MULTIPLE_SPACES_PATTERN.sub(" ", cleaned).strip()

        # Remove trailing punctuation
        cleaned = TRAILING_PUNCTUATION_PATTERN.sub("", cleaned)

        # Remove common banking terms
        cleaned = BANKING_TERMS_PATTERN.sub("", cleaned).strip()

        # Handle special cases
        if len(cleaned) < 2:
            return "Unknown"

        # Capitalize properly
        return MerchantExtractor._proper_case(cleaned)

    @staticmethod
    def _proper_case(text: str) -> str:
        """Convert to proper case (title case)."""
        if not text:
            return text

        return " ".join(
            word[0].upper() + word[1:].lower() if word else word
            for word in text.split(" ")
        )
