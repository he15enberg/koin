"""
Transaction model - mirrors TransactionModel from Dart implementation.
"""

from dataclasses import dataclass, field
from datetime import datetime
from enum import Enum
from typing import Optional


class TransactionType(Enum):
    """Transaction type enumeration."""
    CREDIT = "credit"
    DEBIT = "debit"
    UNKNOWN = "unknown"


@dataclass
class Transaction:
    """
    Represents a parsed bank transaction from SMS.

    Mirrors the SmsTransactionModel from Dart implementation.
    """
    # Bank information
    bank_code: str
    bank_name: str
    bank_photo: str

    # Transaction details
    amount: float
    account_last_four_digits: str
    merchant_name: str
    date_time: datetime
    reference_number: str
    transaction_type: TransactionType

    # Original message
    message_address: str
    message_body: str

    # Category
    category: Optional[str] = None

    # Optional merchant photo
    merchant_photo: Optional[str] = None

    def to_dict(self) -> dict:
        """Convert transaction to dictionary."""
        return {
            "bank_code": self.bank_code,
            "bank_name": self.bank_name,
            "bank_photo": self.bank_photo,
            "amount": self.amount,
            "account_last_four_digits": self.account_last_four_digits,
            "merchant_name": self.merchant_name,
            "date_time": self.date_time.isoformat(),
            "reference_number": self.reference_number,
            "transaction_type": self.transaction_type.value,
            "message_address": self.message_address,
            "message_body": self.message_body,
            "category": self.category,
            "merchant_photo": self.merchant_photo,
        }

    @classmethod
    def from_dict(cls, data: dict) -> "Transaction":
        """Create transaction from dictionary."""
        return cls(
            bank_code=data["bank_code"],
            bank_name=data["bank_name"],
            bank_photo=data["bank_photo"],
            amount=data["amount"],
            account_last_four_digits=data["account_last_four_digits"],
            merchant_name=data["merchant_name"],
            date_time=datetime.fromisoformat(data["date_time"]),
            reference_number=data["reference_number"],
            transaction_type=TransactionType(data["transaction_type"]),
            message_address=data["message_address"],
            message_body=data["message_body"],
            category=data.get("category"),
            merchant_photo=data.get("merchant_photo"),
        )

    def __str__(self) -> str:
        return (
            f"Transaction({self.transaction_type.value}: Rs.{self.amount} "
            f"{'to' if self.transaction_type == TransactionType.DEBIT else 'from'} "
            f"{self.merchant_name} via {self.bank_name})"
        )
