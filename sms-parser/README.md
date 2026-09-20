# SMS Parser

A Python library for extracting and categorizing bank transactions from SMS messages. This module mirrors the Dart implementation from the Koin Flutter app.

## Features

- **Transaction Extraction**: Parse bank SMS messages to extract amount, merchant, account number, reference number
- **Bank Detection**: Support for 50+ Indian and international banks
- **Merchant Extraction**: 7-pattern extraction algorithm for accurate merchant identification
- **Category Classification**: Automatic categorization into 25+ categories (food, shopping, travel, etc.)
- **Type Detection**: Automatic debit/credit transaction type detection

## Installation

```bash
# From the sms-parser directory
pip install -e .

# With development dependencies
pip install -e ".[dev]"
```

## Quick Start

```python
from datetime import datetime
from sms_parser import SmsParser, TransactionType

# Parse a single SMS
result = SmsParser.parse_transaction(
    body="Rs.500 debited from A/c XX1234 to Zomato via UPI. Ref 123456",
    sender="HDFCBK",
    date=datetime.now()
)

if result:
    print(f"Amount: Rs.{result.amount}")
    print(f"Merchant: {result.merchant_name}")
    print(f"Category: {result.category}")
    print(f"Type: {result.transaction_type.value}")
    print(f"Bank: {result.bank_name}")
```

Output:
```
Amount: Rs.500.0
Merchant: Zomato
Category: food & drinks
Type: debit
Bank: HDFC Bank
```

## Usage

### Parse Multiple Messages

```python
messages = [
    {"body": "Rs.100 debited to Amazon", "sender": "HDFCBK", "date": datetime.now()},
    {"body": "Rs.5000 credited salary", "sender": "SBIINB", "date": datetime.now()},
]

transactions = SmsParser.parse_multiple(messages)
for txn in transactions:
    print(txn)
```

### Check if SMS is from a Bank

```python
from sms_parser import SmsParser

SmsParser.is_bank_sms("HDFCBK")  # True
SmsParser.is_bank_sms("AD-SBIINB")  # True
SmsParser.is_bank_sms("RANDOM")  # False
```

### Get Bank Information

```python
from sms_parser import BankDirectory

info = BankDirectory.get_bank_info("HDFCBK")
print(info.name)  # "HDFC Bank"
print(info.dominant_color)  # "#ED232A"

# Get all supported bank codes
codes = BankDirectory.get_bank_codes()
print(len(codes))  # 50+
```

### Classify Transactions

```python
from sms_parser import CategoryClassifier, TransactionType

category = CategoryClassifier.classify_transaction("Zomato", TransactionType.DEBIT)
print(category)  # "food & drinks"

category = CategoryClassifier.classify_transaction("Monthly salary", TransactionType.CREDIT)
print(category)  # "salary"
```

### Extract Merchant Name

```python
from sms_parser import MerchantExtractor, TransactionType

merchant = MerchantExtractor.extract_merchant_name(
    "Rs.500 paid to Amazon for order",
    TransactionType.DEBIT
)
print(merchant)  # "Amazon"
```

## Supported Banks

The library supports 50+ banks including:

### Major Indian Banks
- State Bank of India (SBIINB)
- HDFC Bank (HDFCBK)
- ICICI Bank (ICICIB)
- Axis Bank (AXISBK)
- Kotak Mahindra Bank (KOTAKB)
- Punjab National Bank (PNBSMS)
- Bank of Baroda (BARBNK)
- And many more...

### Payment Banks
- Paytm Payments Bank (PYTMBN)
- Airtel Payments Bank (AIRBNK)
- FINO Payments Bank (FINOPB)

### International Banks
- HSBC (HSBCBK)
- Citi Bank (CITIBK)
- Deutsche Bank (DEUTBK)
- Standard Chartered (SCBK)

## Categories

### Debit Categories
- bills, emi, entertainment, food & drinks, fuel
- groceries, health, investment, shopping
- transfer, travel, other

### Credit Categories
- transfer, deposit, bill_payment, business, credit
- interest, investment, loan, recharge, refund
- reimbursement, reward, salary

## Project Structure

```
sms-parser/
├── __init__.py              # Package exports
├── models/
│   ├── __init__.py
│   └── transaction.py       # Transaction model & TransactionType enum
├── constants/
│   ├── __init__.py
│   ├── banks.py             # Bank directory (50+ banks)
│   ├── categories.py        # Category keywords
│   └── keywords.py          # Transaction type keywords
├── patterns/
│   ├── __init__.py
│   └── regex_patterns.py    # All regex patterns
├── parser/
│   ├── __init__.py
│   ├── sms_parser.py        # Main parser
│   ├── merchant_extractor.py # Merchant extraction
│   └── category_classifier.py # Category classification
├── tests/
│   ├── __init__.py
│   └── test_parser.py       # Unit tests
├── setup.py
├── pyproject.toml
└── README.md
```

## Running Tests

```bash
# Install dev dependencies
pip install -e ".[dev]"

# Run tests
pytest tests/ -v

# Run with coverage
pytest tests/ -v --cov=sms_parser --cov-report=html
```

## API Reference

### SmsParser

| Method | Description |
|--------|-------------|
| `parse_transaction(body, sender, date)` | Parse single SMS message |
| `parse_multiple(messages)` | Parse list of messages |
| `is_bank_sms(sender)` | Check if sender is a known bank |

### Transaction

| Field | Type | Description |
|-------|------|-------------|
| `amount` | float | Transaction amount |
| `merchant_name` | str | Extracted merchant name |
| `category` | str | Transaction category |
| `transaction_type` | TransactionType | CREDIT, DEBIT, or UNKNOWN |
| `bank_code` | str | Bank SMS code |
| `bank_name` | str | Full bank name |
| `account_last_four_digits` | str | Last 4 digits of account |
| `reference_number` | str | Transaction reference |
| `date_time` | datetime | Transaction date/time |
| `message_body` | str | Original SMS text |

### BankDirectory

| Method | Description |
|--------|-------------|
| `get_bank_codes()` | Get list of all bank codes |
| `get_bank_info(code)` | Get BankInfo for a code |
| `is_bank_sender(sender)` | Check if sender matches a bank |
| `find_bank_code(sender)` | Extract bank code from sender |

## License

MIT License
