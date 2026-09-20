"""
Regex patterns for SMS parsing.

Mirrors all regex patterns from:
- sms_parser.dart
- merchant_name.dart

All patterns are pre-compiled for performance.
"""

import re
from typing import List, Pattern

# =============================================================================
# AMOUNT EXTRACTION
# =============================================================================

# Pattern to extract amount from SMS
# Matches: Rs.500, Rs. 1,500.00, Rs1000, INR 25,000.00, ₹500, etc.
# Real-world data showed ~2% of genuine transactions (incl. salary credits)
# use "INR" with no "Rs" at all -- the old Rs-only pattern silently dropped them.
AMOUNT_PATTERN: Pattern = re.compile(
    r'(?:Rs\.?|INR|₹)\s*(\d+(?:,\d+)*(?:\.\d+)?)',
    re.IGNORECASE
)

# =============================================================================
# NON-TRANSACTION GUARDS
# =============================================================================

# A "money request" (Google Pay/UPI collect requests) or a future-tense
# "will be debited/credited" is NOT a completed transaction -- the money
# hasn't moved yet. These matter once AMOUNT_PATTERN also accepts "INR",
# since most of these requests are phrased with INR and would otherwise be
# misread as completed debits.
PENDING_ACTION_PATTERN: Pattern = re.compile(
    r'has requested money from you|will be debited|will be credited|'
    r'requested money from you',
    re.IGNORECASE
)

# Marketing/promotional SMS that happen to mention an amount (credit limits,
# vouchers, loan offers) but describe no real transaction.
PROMOTIONAL_CONTENT_PATTERN: Pattern = re.compile(
    r'\bt&c\b|\bhurry\b|pre-approved|lifetime free|apply now|apply online|'
    r'click here|scheduled maintenance|congrats!|voucher with your|'
    r'get upto rs|credit card is free',
    re.IGNORECASE
)

# =============================================================================
# ACCOUNT NUMBER EXTRACTION
# =============================================================================

# Pattern to extract account last 4 digits
# Matches: XXXX1234, ****1234, xx1234, or plain 4 digits
ACCOUNT_PATTERN: Pattern = re.compile(
    r'[xX*]{4,}\d{4}|\d{4}'
)

# =============================================================================
# REFERENCE NUMBER EXTRACTION
# =============================================================================

# Pattern to extract transaction reference number
# Matches: Ref: ABC123, UPI Ref 123456, Txn. XYZ789
REFERENCE_PATTERN: Pattern = re.compile(
    r'Ref\.?\s*:?\s*(\w+)|UPI Ref\.?\s*(\w+)|Txn\.?\s*(\w+)',
    re.IGNORECASE
)

# =============================================================================
# MERCHANT EXTRACTION PATTERNS
# =============================================================================

# Pattern 1: Payee-based extraction (highest priority)
# Matches: "payee John Doe", "paid to Amazon", "sent to Zomato", "transferred to XYZ"
PAYEE_PATTERN: Pattern = re.compile(
    r'(?:payee|paid\s+to|sent\s+to|transferred\s+to|^to)\s+([A-Za-z0-9@._&\s-]+?)(?=\s+for\b|\s+Rs\.?\b|\s+INR\b|\s+on\b|\.|,|\n|$)',
    re.IGNORECASE | re.MULTILINE
)

# Pattern 2: UPI-specific patterns
UPI_PATTERNS: List[Pattern] = [
    # VPA: merchant@bank - preserves full UPI ID
    re.compile(
        r'VPA[:\s]+([A-Za-z0-9._-]+@[A-Za-z0-9.-]+)',
        re.IGNORECASE
    ),
    # from VPA merchant@bank - preserves full UPI ID
    re.compile(
        r'from\s+VPA\s+([A-Za-z0-9._-]+@[A-Za-z0-9.-]+)',
        re.IGNORECASE
    ),
    # UPI/MERCHANT@bank or UPI-MERCHANT@bank - extracts merchant part only
    re.compile(
        r'UPI[/-]([A-Za-z0-9._-]+)@[A-Za-z0-9.-]+',
        re.IGNORECASE
    ),
    # UPI/MERCHANT/
    re.compile(
        r'UPI/([A-Za-z0-9\s._&-]{2,30})/',
        re.IGNORECASE
    ),
    # UPI-MERCHANT-
    re.compile(
        r'UPI-([A-Za-z0-9\s._&-]{2,30})-',
        re.IGNORECASE
    ),
    # Simple UPI pattern
    re.compile(
        r'UPI\s+([A-Za-z0-9\s._&-]{2,30})',
        re.IGNORECASE
    ),
]

# Pattern 3: At/To patterns
# Matches: "at Zomato", "to Amazon", "@ McDonald's"
# "at"/"to" are word-boundary-anchored -- without it this used to match "to"
# embedded at the tail of an unrelated word (e.g. "ZOMATO order" matched
# the "TO" inside "ZOMATO" itself and extracted "order" as the merchant).
AT_TO_PATTERN: Pattern = re.compile(
    r'(?:\bat|\bto|@)\s+([A-Za-z0-9@._&\s-]{2,50})(?=\s+on\b|\s+for\b|\s+Rs\.?\b|\s+INR\b|\s+via\b|\.|,|\n|$)',
    re.IGNORECASE
)

# Pattern 4: Via patterns
# Matches: "via PhonePe", "via GPAY"
VIA_PATTERN: Pattern = re.compile(
    r'via\s+([A-Za-z0-9@._&\s-]{2,30})(?=\s+on\b|\s+Rs\.?\b|\s+INR\b|\.|,|\n|$)',
    re.IGNORECASE
)

# Pattern 5: Transfer patterns
TRANSFER_PATTERNS: List[Pattern] = [
    # From/To patterns for transfers
    re.compile(
        r'(?:from|received\s+from)\s+([A-Za-z0-9@._&\s-]{2,40})(?=\s+on\b|\s+via\b|\.|,|\n|$)',
        re.IGNORECASE
    ),
    re.compile(
        r'(?:transfer\s+to|sent\s+to)\s+([A-Za-z0-9@._&\s-]{2,40})(?=\s+on\b|\s+via\b|\.|,|\n|$)',
        re.IGNORECASE
    ),
]

# Pattern 7: Email-like patterns
# Matches email addresses and extracts the part before @
EMAIL_PATTERN: Pattern = re.compile(
    r'([A-Za-z0-9._-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,})',
    re.IGNORECASE
)

# =============================================================================
# MERCHANT NAME CLEANING PATTERNS
# =============================================================================

# Prefixes to remove (Mr, Ms, Dr, etc.)
PREFIX_PATTERN: Pattern = re.compile(
    r'^\s*(MR|MS|DR|SRI|SHRI|SMT)\.?\s+',
    re.IGNORECASE
)

# Suffixes to remove (PVT, LTD, etc.)
SUFFIX_PATTERN: Pattern = re.compile(
    r'\s+(PVT|LTD|LLP|INC|CORP|CO|PRIVATE|LIMITED)\.?\s*$',
    re.IGNORECASE
)

# Multiple spaces to single space
MULTIPLE_SPACES_PATTERN: Pattern = re.compile(r'\s+')

# Trailing punctuation
TRAILING_PUNCTUATION_PATTERN: Pattern = re.compile(r'[.,;:!?]+$')

# Banking terms to remove
BANKING_TERMS_PATTERN: Pattern = re.compile(
    r'\b(BANK|BANKING|FINANCIAL|SERVICES|PAYMENT|TRANSACTION)\b',
    re.IGNORECASE
)
