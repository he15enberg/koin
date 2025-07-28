import 'package:koin/features/authentication/models/transaction_model.dart';

class MerchantExtractor {
  static String extractMerchantName(
    String messageBody,
    SmsTransactionType smsType,
  ) {
    final body = messageBody.trim();

    // Try multiple extraction patterns in order of priority
    final extractors = [
      _extractFromPayeePattern,
      _extractFromUpiPattern,
      _extractFromAtToPattern,
      _extractFromViaPattern,
      _extractFromTransferPattern,
      _extractFromCommonMerchants,
      _extractFromEmailPattern,
    ];

    for (final extractor in extractors) {
      final merchantName = extractor(body, smsType);
      if (merchantName.isNotEmpty && merchantName != 'Unknown') {
        return _cleanMerchantName(merchantName);
      }
    }

    return 'Unknown';
  }

  // Pattern 1: Payee-based extraction (highest priority)
  // Pattern 1: Payee-based extraction (highest priority) - FIXED
  // Pattern 1: Payee-based extraction (highest priority) - FIXED
  static String _extractFromPayeePattern(
    String body,
    SmsTransactionType smsType,
  ) {
    final payeeRegex = RegExp(
      r'(?:payee|paid\s+to|sent\s+to|transferred\s+to|^to)\s+([A-Za-z0-9@._&\s-]+?)(?=\s+for\b|\s+Rs\.?\b|\s+INR\b|\s+on\b|\.|,|\n|$)',
      caseSensitive: false,
      multiLine: true, // Added this flag
    );

    final match = payeeRegex.firstMatch(body);
    return match?.group(1)?.trim() ?? '';
  }

  // Pattern 2: UPI-specific patterns
  // Pattern 2: UPI-specific patterns - FIXED
  static String _extractFromUpiPattern(
    String body,
    SmsTransactionType smsType,
  ) {
    final upiPatterns = [
      // VPA: merchant@bank - should preserve full UPI ID
      RegExp(
        r'VPA[:\s]+([A-Za-z0-9._-]+@[A-Za-z0-9.-]+)',
        caseSensitive: false,
      ),
      // from VPA merchant@bank - should preserve full UPI ID
      RegExp(
        r'from\s+VPA\s+([A-Za-z0-9._-]+@[A-Za-z0-9.-]+)',
        caseSensitive: false,
      ),
      // UPI/MERCHANT@bank or UPI-MERCHANT@bank - for these, extract merchant part only
      RegExp(r'UPI[/-]([A-Za-z0-9._-]+)@[A-Za-z0-9.-]+', caseSensitive: false),
      // UPI/MERCHANT/
      RegExp(r'UPI/([A-Za-z0-9\s._&-]{2,30})/', caseSensitive: false),
      // UPI-MERCHANT-
      RegExp(r'UPI-([A-Za-z0-9\s._&-]{2,30})-', caseSensitive: false),
      // Simple UPI pattern
      RegExp(r'UPI\s+([A-Za-z0-9\s._&-]{2,30})', caseSensitive: false),
    ];

    for (int i = 0; i < upiPatterns.length; i++) {
      final pattern = upiPatterns[i];
      final match = pattern.firstMatch(body);
      if (match != null) {
        String merchant = match.group(1) ?? '';

        // For VPA patterns (first two), preserve the full UPI ID
        if (i <= 1) {
          return merchant.trim();
        }

        // For other UPI patterns, extract merchant part if it contains @
        if (merchant.contains('@')) {
          merchant = merchant.split('@')[0];
        }
        return merchant.trim();
      }
    }

    // If UPI found but no merchant extracted, return transaction type
    if (body.toLowerCase().contains('upi')) {
      return smsType.name;
    }

    return '';
  }

  // Pattern 3: At/To patterns (enhanced)
  static String _extractFromAtToPattern(
    String body,
    SmsTransactionType smsType,
  ) {
    final atToRegex = RegExp(
      r'(?:at|to|@)\s+([A-Za-z0-9@._&\s-]{2,50})(?=\s+on\b|\s+for\b|\s+Rs\.?\b|\s+INR\b|\s+via\b|\.|,|\n|$)',
      caseSensitive: false,
    );

    final match = atToRegex.firstMatch(body);
    return match?.group(1)?.trim() ?? '';
  }

  // Pattern 4: Via patterns (payment apps, methods)
  static String _extractFromViaPattern(
    String body,
    SmsTransactionType smsType,
  ) {
    final viaRegex = RegExp(
      r'via\s+([A-Za-z0-9@._&\s-]{2,30})(?=\s+on\b|\s+Rs\.?\b|\s+INR\b|\.|,|\n|$)',
      caseSensitive: false,
    );

    final match = viaRegex.firstMatch(body);
    return match?.group(1)?.trim() ?? '';
  }

  // Pattern 5: Transfer patterns
  static String _extractFromTransferPattern(
    String body,
    SmsTransactionType smsType,
  ) {
    final transferPatterns = [
      // From/To patterns for transfers
      RegExp(
        r'(?:from|received\s+from)\s+([A-Za-z0-9@._&\s-]{2,40})(?=\s+on\b|\s+via\b|\.|,|\n|$)',
        caseSensitive: false,
      ),
      RegExp(
        r'(?:transfer\s+to|sent\s+to)\s+([A-Za-z0-9@._&\s-]{2,40})(?=\s+on\b|\s+via\b|\.|,|\n|$)',
        caseSensitive: false,
      ),
    ];

    for (final pattern in transferPatterns) {
      final match = pattern.firstMatch(body);
      if (match != null) {
        return match.group(1)?.trim() ?? '';
      }
    }

    return '';
  }

  // Pattern 6: Common merchant names (exact matches)
  static String _extractFromCommonMerchants(
    String body,
    SmsTransactionType smsType,
  ) {
    final commonMerchants = [
      'ZOMATO',
      'SWIGGY',
      'UBER',
      'OLA',
      'AMAZON',
      'FLIPKART',
      'MYNTRA',
      'GPAY',
      'PHONEPE',
      'PAYTM',
      'NETFLIX',
      'HOTSTAR',
      'SPOTIFY',
      'DOMINOS',
      'PIZZA HUT',
      'KFC',
      'MCDONALDS',
      'STARBUCKS',
      'RELIANCE',
      'DMART',
      'BIG BAZAAR',
      'AIRTEL',
      'JIO',
      'VI',
    ];

    final bodyUpper = body.toUpperCase();
    for (final merchant in commonMerchants) {
      if (bodyUpper.contains(merchant)) {
        return merchant;
      }
    }

    return '';
  }

  // Pattern 7: Email-like patterns
  static String _extractFromEmailPattern(
    String body,
    SmsTransactionType smsType,
  ) {
    final emailRegex = RegExp(
      r'([A-Za-z0-9._-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,})',
      caseSensitive: false,
    );
    final match = emailRegex.firstMatch(body);

    if (match != null) {
      final email = match.group(1) ?? '';
      // Extract merchant name before @
      return email.split('@')[0];
    }

    return '';
  }

  // Clean and normalize merchant name
  static String _cleanMerchantName(String merchantName) {
    if (merchantName.isEmpty) return 'Unknown';

    // Remove common prefixes and suffixes
    String cleaned = merchantName
        .replaceAll(
          RegExp(r'^\s*(MR|MS|DR|SRI|SHRI|SMT)\.?\s+', caseSensitive: false),
          '',
        )
        .replaceAll(
          RegExp(
            r'\s+(PVT|LTD|LLP|INC|CORP|CO|PRIVATE|LIMITED)\.?\s*$',
            caseSensitive: false,
          ),
          '',
        )
        .replaceAll(RegExp(r'\s+'), ' ') // Multiple spaces to single space
        .trim();

    // Remove trailing punctuation
    cleaned = cleaned.replaceAll(RegExp(r'[.,;:!?]+$'), '');

    // Remove common banking terms
    cleaned = cleaned
        .replaceAll(
          RegExp(
            r'\b(BANK|BANKING|FINANCIAL|SERVICES|PAYMENT|TRANSACTION)\b',
            caseSensitive: false,
          ),
          '',
        )
        .trim();

    // Handle special cases
    if (cleaned.length < 2) {
      return 'Unknown';
    }

    // Capitalize properly
    return _properCase(cleaned);
  }

  // Convert to proper case
  static String _properCase(String text) {
    if (text.isEmpty) return text;

    return text
        .toLowerCase()
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1);
        })
        .join(' ');
  }
}
