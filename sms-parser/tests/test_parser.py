"""
Unit tests for SMS Parser module.

Tests mirror the functionality from the Dart implementation.
Run with: pytest tests/test_parser.py -v
"""

import pytest
from datetime import datetime

from sms_parser import (
    SmsParser,
    Transaction,
    TransactionType,
    MerchantExtractor,
    CategoryClassifier,
    BankDirectory,
)


class TestSmsParser:
    """Tests for the main SmsParser class."""

    def test_parse_debit_transaction(self):
        """Test parsing a debit transaction SMS."""
        body = "Rs.500 debited from A/c XX1234 to Zomato on 01-01-2024. UPI Ref 123456789"
        sender = "HDFCBK"

        result = SmsParser.parse_transaction(body, sender)

        assert result is not None
        assert result.amount == 500.0
        assert result.transaction_type == TransactionType.DEBIT
        assert result.bank_code == "HDFCBK"
        assert result.bank_name == "HDFC Bank"
        assert "1234" in result.account_last_four_digits
        assert result.reference_number == "123456789"

    def test_parse_credit_transaction(self):
        """Test parsing a credit transaction SMS."""
        body = "Rs.10,000.00 credited to A/c XX5678 from SALARY for Jan 2024"
        sender = "SBIINB"

        result = SmsParser.parse_transaction(body, sender)

        assert result is not None
        assert result.amount == 10000.0
        assert result.transaction_type == TransactionType.CREDIT
        assert result.bank_code == "SBIINB"
        assert result.bank_name == "State Bank of India"

    def test_parse_upi_transaction(self):
        """Test parsing a UPI transaction."""
        body = "Rs.250 debited from A/c XX9999 VPA: merchant@okicici for Food"
        sender = "ICICIB"

        result = SmsParser.parse_transaction(body, sender)

        assert result is not None
        assert result.amount == 250.0
        assert result.transaction_type == TransactionType.DEBIT

    def test_invalid_sms_no_amount(self):
        """Test that SMS without amount returns None."""
        body = "Your OTP is 123456. Valid for 5 minutes."
        sender = "HDFCBK"

        result = SmsParser.parse_transaction(body, sender)

        assert result is None

    def test_empty_body(self):
        """Test that empty body returns None."""
        result = SmsParser.parse_transaction("", "HDFCBK")
        assert result is None

    def test_empty_sender(self):
        """Test that empty sender returns None."""
        result = SmsParser.parse_transaction("Rs.500 debited", "")
        assert result is None

    def test_is_bank_sms(self):
        """Test bank SMS detection."""
        assert SmsParser.is_bank_sms("HDFCBK") is True
        assert SmsParser.is_bank_sms("AD-HDFCBK") is True
        assert SmsParser.is_bank_sms("RANDOM") is False

    def test_parse_multiple(self):
        """Test parsing multiple messages."""
        messages = [
            {
                "body": "Rs.100 debited from A/c XX1234 to Amazon",
                "sender": "HDFCBK",
                "date": datetime(2024, 1, 1),
            },
            {
                "body": "Rs.200 credited to A/c XX5678",
                "sender": "SBIINB",
                "date": datetime(2024, 1, 2),
            },
            {
                "body": "Invalid SMS without amount",
                "sender": "ICICIB",
                "date": datetime(2024, 1, 3),
            },
        ]

        results = SmsParser.parse_multiple(messages)

        assert len(results) == 2
        assert results[0].amount == 100.0
        assert results[1].amount == 200.0


class TestMerchantExtractor:
    """Tests for merchant name extraction."""

    def test_extract_payee_pattern(self):
        """Test payee pattern extraction."""
        body = "Rs.500 paid to Amazon for order"
        result = MerchantExtractor.extract_merchant_name(body, TransactionType.DEBIT)
        assert "Amazon" in result

    def test_extract_upi_vpa(self):
        """Test UPI VPA extraction."""
        body = "Rs.100 debited VPA: merchant@okicici"
        result = MerchantExtractor.extract_merchant_name(body, TransactionType.DEBIT)
        assert "merchant@okicici" in result.lower()

    def test_extract_at_pattern(self):
        """Test 'at' pattern extraction."""
        body = "Rs.300 spent at Starbucks on 01-01-2024"
        result = MerchantExtractor.extract_merchant_name(body, TransactionType.DEBIT)
        assert "Starbucks" in result

    def test_extract_common_merchant(self):
        """Test common merchant extraction."""
        body = "Rs.400 debited for ZOMATO order"
        result = MerchantExtractor.extract_merchant_name(body, TransactionType.DEBIT)
        assert "ZOMATO" in result.upper()

    def test_unknown_merchant(self):
        """Test fallback to Unknown."""
        body = "Rs.500 debited from account"
        result = MerchantExtractor.extract_merchant_name(body, TransactionType.DEBIT)
        # Should return something (might be Unknown or a partial match)
        assert result is not None


class TestCategoryClassifier:
    """Tests for category classification."""

    def test_classify_food(self):
        """Test food category classification."""
        result = CategoryClassifier.classify_transaction("Zomato", TransactionType.DEBIT)
        assert result == "food & drinks"

    def test_classify_shopping(self):
        """Test shopping category classification."""
        result = CategoryClassifier.classify_transaction("Amazon", TransactionType.DEBIT)
        assert result == "shopping"

    def test_classify_travel(self):
        """Test travel category classification."""
        result = CategoryClassifier.classify_transaction("Uber", TransactionType.DEBIT)
        assert result == "travel"

    def test_classify_salary(self):
        """Test salary category classification."""
        result = CategoryClassifier.classify_transaction(
            "Monthly salary credited", TransactionType.CREDIT
        )
        assert result == "salary"

    def test_classify_refund(self):
        """Test refund category classification."""
        result = CategoryClassifier.classify_transaction(
            "Amazon refund processed", TransactionType.CREDIT
        )
        assert result == "refund"

    def test_no_category(self):
        """Test no category match."""
        result = CategoryClassifier.classify_transaction(
            "Random merchant XYZ", TransactionType.DEBIT
        )
        assert result is None

    def test_unknown_transaction_type(self):
        """Test unknown transaction type."""
        result = CategoryClassifier.classify_transaction(
            "Zomato", TransactionType.UNKNOWN
        )
        assert result is None


class TestBankDirectory:
    """Tests for bank directory."""

    def test_get_bank_codes(self):
        """Test getting all bank codes."""
        codes = BankDirectory.get_bank_codes()
        assert len(codes) > 50  # Should have 50+ banks
        assert "HDFCBK" in codes
        assert "SBIINB" in codes
        assert "ICICIB" in codes

    def test_get_bank_info(self):
        """Test getting bank info by code."""
        info = BankDirectory.get_bank_info("HDFCBK")
        assert info is not None
        assert info.name == "HDFC Bank"
        assert info.code == "HDFCBK"

    def test_get_bank_info_case_insensitive(self):
        """Test case insensitive bank code lookup."""
        info = BankDirectory.get_bank_info("hdfcbk")
        assert info is not None
        assert info.name == "HDFC Bank"

    def test_get_bank_info_not_found(self):
        """Test bank not found."""
        info = BankDirectory.get_bank_info("NOTABANK")
        assert info is None

    def test_is_bank_sender(self):
        """Test bank sender detection."""
        assert BankDirectory.is_bank_sender("HDFCBK") is True
        assert BankDirectory.is_bank_sender("AD-SBIINB") is True
        assert BankDirectory.is_bank_sender("RANDOM123") is False

    def test_find_bank_code(self):
        """Test finding bank code from sender."""
        assert BankDirectory.find_bank_code("AD-HDFCBK") == "HDFCBK"
        assert BankDirectory.find_bank_code("VM-SBIINB") == "SBIINB"
        assert BankDirectory.find_bank_code("RANDOM") is None


class TestTransaction:
    """Tests for Transaction model."""

    def test_transaction_to_dict(self):
        """Test transaction serialization."""
        txn = Transaction(
            bank_code="HDFCBK",
            bank_name="HDFC Bank",
            bank_photo="assets/logos/HDFC Bank.png",
            amount=500.0,
            account_last_four_digits="1234",
            merchant_name="Zomato",
            date_time=datetime(2024, 1, 1, 12, 0, 0),
            reference_number="REF123",
            transaction_type=TransactionType.DEBIT,
            message_address="HDFCBK",
            message_body="Rs.500 debited",
            category="food & drinks",
        )

        data = txn.to_dict()

        assert data["amount"] == 500.0
        assert data["merchant_name"] == "Zomato"
        assert data["transaction_type"] == "debit"
        assert data["category"] == "food & drinks"

    def test_transaction_from_dict(self):
        """Test transaction deserialization."""
        data = {
            "bank_code": "HDFCBK",
            "bank_name": "HDFC Bank",
            "bank_photo": "assets/logos/HDFC Bank.png",
            "amount": 500.0,
            "account_last_four_digits": "1234",
            "merchant_name": "Zomato",
            "date_time": "2024-01-01T12:00:00",
            "reference_number": "REF123",
            "transaction_type": "debit",
            "message_address": "HDFCBK",
            "message_body": "Rs.500 debited",
            "category": "food & drinks",
        }

        txn = Transaction.from_dict(data)

        assert txn.amount == 500.0
        assert txn.merchant_name == "Zomato"
        assert txn.transaction_type == TransactionType.DEBIT

    def test_transaction_str(self):
        """Test transaction string representation."""
        txn = Transaction(
            bank_code="HDFCBK",
            bank_name="HDFC Bank",
            bank_photo="",
            amount=500.0,
            account_last_four_digits="1234",
            merchant_name="Zomato",
            date_time=datetime.now(),
            reference_number="",
            transaction_type=TransactionType.DEBIT,
            message_address="HDFCBK",
            message_body="",
        )

        result = str(txn)
        assert "500" in result
        assert "Zomato" in result
        assert "debit" in result


class TestAmountExtraction:
    """Tests for amount extraction patterns."""

    def test_amount_with_comma(self):
        """Test amount with comma separator."""
        body = "Rs.1,500.00 debited from account"
        result = SmsParser.parse_transaction(body, "HDFCBK")
        assert result is not None
        assert result.amount == 1500.0

    def test_amount_without_comma(self):
        """Test amount without comma."""
        body = "Rs.500 debited from account"
        result = SmsParser.parse_transaction(body, "HDFCBK")
        assert result is not None
        assert result.amount == 500.0

    def test_amount_with_decimal(self):
        """Test amount with decimal places."""
        body = "Rs.99.50 debited from account"
        result = SmsParser.parse_transaction(body, "HDFCBK")
        assert result is not None
        assert result.amount == 99.50

    def test_amount_large_value(self):
        """Test large amount value."""
        body = "Rs.1,00,000.00 credited to account"
        result = SmsParser.parse_transaction(body, "SBIINB")
        assert result is not None
        assert result.amount == 100000.0


class TestTransactionTypeDetection:
    """Tests for transaction type detection."""

    def test_debit_keywords(self):
        """Test debit keyword detection."""
        debit_messages = [
            "Rs.500 debited from account",
            "Rs.500 has been debit from your account",
            "Rs.500 sent to merchant",
            "Rs.500 withdrawn from ATM",
            "Rs.500 purchase at store",
            "Rs.500 spent at restaurant",
            "Rs.500 paid to vendor",
        ]

        for body in debit_messages:
            result = SmsParser.parse_transaction(body, "HDFCBK")
            assert result is not None, f"Failed for: {body}"
            assert result.transaction_type == TransactionType.DEBIT, f"Failed for: {body}"

    def test_credit_keywords(self):
        """Test credit keyword detection."""
        credit_messages = [
            "Rs.500 credited to account",
            "Rs.500 credit received",
            "Rs.500 received from sender",
            "Rs.500 deposit to account",
            "Rs.500 added to wallet",
        ]

        for body in credit_messages:
            result = SmsParser.parse_transaction(body, "HDFCBK")
            assert result is not None, f"Failed for: {body}"
            assert result.transaction_type == TransactionType.CREDIT, f"Failed for: {body}"


if __name__ == "__main__":
    pytest.main([__file__, "-v"])
