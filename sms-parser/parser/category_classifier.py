"""
Category classifier - mirrors cateogry_classifier.dart

Classifies transactions into categories based on merchant name keywords.
Uses word boundary matching for accurate classification.
"""

import re
from typing import Optional
from ..models.transaction import TransactionType
from ..constants.categories import SPEND_KEYWORDS, CREDIT_KEYWORDS

# A merchant name that is just 2-4 Title-Case words (letters only, no digits,
# no '@', not a known template artifact) is almost always a P2P UPI transfer
# to a named person -- e.g. "Sunil Kumar Kushwaha", "Shobha S". On real data
# this pattern alone accounted for 41% of otherwise-uncategorized
# transactions, so it gets a dedicated fallback rather than being left blank.
_PERSON_NAME_PATTERN = re.compile(r'^[A-Z][a-zA-Z]*(?:\s[A-Z][a-zA-Z]*){1,3}$')
_PERSON_NAME_EXCLUDED = {"Unknown", "Debit", "Credit", "Ref", "Rs"}


class CategoryClassifier:
    """
    Classifies transactions into categories.
    Mirrors CategoryClassifier from Dart implementation.
    """

    @classmethod
    def classify_transaction(
        cls,
        merchant_name: str,
        transaction_type: TransactionType,
    ) -> Optional[str]:
        """
        Classify a transaction based on merchant name and transaction type.

        Args:
            merchant_name: The extracted merchant name
            transaction_type: The transaction type (credit/debit)

        Returns:
            Category string or None if no category found
        """
        lower_merchant_name = merchant_name.lower()

        # Select keyword dictionary based on transaction type
        if transaction_type == TransactionType.DEBIT:
            keywords = SPEND_KEYWORDS
        elif transaction_type == TransactionType.CREDIT:
            keywords = CREDIT_KEYWORDS
        else:
            return None

        # Check each category using word boundaries, tolerant of simple
        # suffixes (plurals etc.) -- e.g. keyword "food" also matches
        # "Foods", keyword "departmental store" also matches "... Stores".
        # A strict trailing \b missed these entirely on real merchant names.
        for category, category_keywords in keywords.items():
            for keyword in category_keywords:
                pattern = r'\b' + re.escape(keyword.lower()) + r'\w*'
                if re.search(pattern, lower_merchant_name):
                    return category

        # No keyword matched -- fall back to the person-name heuristic
        # before giving up entirely.
        if merchant_name not in _PERSON_NAME_EXCLUDED and _PERSON_NAME_PATTERN.match(merchant_name):
            return "transfer"

        return None

    @classmethod
    def get_spend_categories(cls) -> list:
        """Get list of all spend (debit) categories."""
        return list(SPEND_KEYWORDS.keys())

    @classmethod
    def get_credit_categories(cls) -> list:
        """Get list of all credit categories."""
        return list(CREDIT_KEYWORDS.keys())

    @classmethod
    def get_keywords_for_category(
        cls,
        category: str,
        transaction_type: TransactionType,
    ) -> list:
        """
        Get all keywords for a specific category.

        Args:
            category: The category name
            transaction_type: The transaction type

        Returns:
            List of keywords for the category
        """
        if transaction_type == TransactionType.DEBIT:
            return SPEND_KEYWORDS.get(category, [])
        elif transaction_type == TransactionType.CREDIT:
            return CREDIT_KEYWORDS.get(category, [])
        return []
