import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:koin/services/sms_engine/sms_transaction_model.dart';
import 'package:koin/services/sms_engine/bank_directory.dart';
import 'package:koin/services/sms_engine/category_classifier.dart';
import 'package:koin/services/sms_engine/merchant_extractor.dart';

class SmsParser {
  static SmsTransactionModel? parseTransaction(dynamic msg) {
    try {
      // Extract common fields from either message type
      String body;
      String sender;
      DateTime date;

      if (msg is SmsMessage) {
        // flutter_sms_inbox message
        body = msg.body ?? '';
        sender = msg.address ?? '';
        date = msg.date ?? DateTime.now();
      } else {
        // another_telephony message or background service message
        body = msg.body ?? '';
        sender = msg.address ?? '';
        // Handle different date property names safely
        try {
          date = msg.date ?? DateTime.now();
        } catch (e) {
          // If date property doesn't exist, use current time
          date = DateTime.now();
        }
      }

      if (body.isEmpty || sender.isEmpty) return null;

      // Known non-transactional channels (marketing / public-awareness
      // broadcasts) -- verified against live data, never a real transaction.
      if (SmsParserHelper.nonTransactionalSenderCodes.any(
        (code) => sender.toUpperCase().contains(code),
      )) {
        return null;
      }

      // A pending money *request* or a future-tense "will be
      // debited/credited" describes money that hasn't moved yet.
      if (SmsParserHelper.pendingActionRegex.hasMatch(body)) {
        return null;
      }

      // Marketing SMS that mentions an amount (credit limit, voucher, loan
      // offer) but describes no real transaction.
      if (SmsParserHelper.promotionalContentRegex.hasMatch(body)) {
        return null;
      }

      final bankCodes = BankDirectory.getBankCodes();

      // Extract bank code
      final bankCode = bankCodes.firstWhere(
        (code) => sender.toUpperCase().contains(code.toUpperCase()),
        orElse: () => sender,
      );

      // Add Bank Info
      final bankInfo = BankDirectory.getBankInfo(bankCode);
      final bankName = bankInfo?.name ?? bankCode;
      final bankPhoto = bankInfo?.image ?? '';

      // Extract amount using regex. Accepts INR/₹ as well as Rs -- real
      // data showed ~2% of genuine transactions (incl. salary credits) use
      // "INR" with no "Rs" at all, which used to be silently dropped.
      final amountRegex = RegExp(
        r'(?:Rs\.?|INR|₹)\s*(\d+(?:,\d+)*(?:\.\d+)?)',
        caseSensitive: false,
      );
      final amountMatch = amountRegex.firstMatch(body);
      final amount = amountMatch != null
          ? double.tryParse(amountMatch.group(1)!.replaceAll(',', '')) ?? 0.0
          : 0.0;

      if (amount <= 0) return null;

      // Extract account last 4 digits
      final accountRegex = RegExp(r'[xX*]{4,}\d{4}|\d{4}');
      final accountMatch = accountRegex.firstMatch(body);
      final accountLastFour =
          accountMatch?.group(0)?.replaceAll(RegExp(r'[xX*]'), '') ?? '';

      final SmsTransactionType smsType = SmsParserHelper.getTransactionType(
        body,
      );

      String merchantName = MerchantExtractor.extractMerchantName(
        body,
        smsType,
      );

      // Extract reference number
      final refRegex = RegExp(
        r'Ref\.?\s*:?\s*(\w+)|UPI Ref\.?\s*(\w+)|Txn\.?\s*(\w+)',
      );
      final refMatch = refRegex.firstMatch(body);
      final referenceNumber =
          refMatch?.group(1) ?? refMatch?.group(2) ?? refMatch?.group(3) ?? '';

      // Classify transaction category
      final category = CategoryClassifier.classifyTransaction(
        merchantName,
        smsType,
      );

      return SmsTransactionModel(
        bankCode: bankCode,
        amount: amount,
        bankName: bankName,
        bankPhoto: bankPhoto,
        accountLastFourDigits: accountLastFour,
        merchantName: merchantName,
        dateTime: date,
        referenceNumber: referenceNumber,
        smsType: smsType,
        messageAddress: sender,
        messageBody: body,
        merchantPhoto: null,
        category: category,
      );
    } catch (e) {
      print('Error parsing transaction: $e');
      return null;
    }
  }
}

class SmsParserHelper {
  static const List<String> debitKeywords = [
    'debited',
    'debit',
    'sent',
    'withdrawn',
    'purchase',
    'spent',
    'paid',
    'transferred',
  ];

  static const List<String> creditKeywords = [
    'credited',
    'credit',
    'received',
    'deposit',
    'added',
  ];

  // Bank shorthand for Debit/Credit (e.g. "Rs.18.00 Dr. from A/C ... Cr. to
  // ..."). Kept out of the plain substring lists above because a bare
  // "dr"/"cr" would false-positive on ordinary words (e.g. "address"
  // contains "dr"); word-boundary regex avoids that.
  static final RegExp debitShorthandRegex = RegExp(
    r'\bdr\.',
    caseSensitive: false,
  );
  static final RegExp creditShorthandRegex = RegExp(
    r'\bcr\.',
    caseSensitive: false,
  );

  // A "money request" (Google Pay/UPI collect requests) or a future-tense
  // "will be debited/credited" is NOT a completed transaction -- the money
  // hasn't moved yet.
  static final RegExp pendingActionRegex = RegExp(
    r'has requested money from you|will be debited|will be credited|'
    r'requested money from you',
    caseSensitive: false,
  );

  // Marketing/promotional SMS that happen to mention an amount (credit
  // limits, vouchers, loan offers) but describe no real transaction.
  static final RegExp promotionalContentRegex = RegExp(
    r'\bt&c\b|\bhurry\b|pre-approved|lifetime free|apply now|apply online|'
    r'click here|scheduled maintenance|congrats!|voucher with your|'
    r'get upto rs|credit card is free',
    caseSensitive: false,
  );

  // Sender codes that are structurally non-transactional (verified against
  // real data: HDFCBN carries only credit-card/loan marketing, RBISAY only
  // carries RBI's public fraud-awareness broadcasts) -- never a real txn.
  static const List<String> nonTransactionalSenderCodes = [
    'HDFCBN',
    'RBISAY',
  ];

  static SmsTransactionType getTransactionType(String body) {
    final lowerBody = body.toLowerCase();

    // Debit checked first: for a message describing money leaving one
    // account and landing in another (e.g. "Dr. from A/C X and Cr. to Y"),
    // the classification is from the account holder's own perspective,
    // i.e. a debit.
    if (debitKeywords.any((kw) => lowerBody.contains(kw)) ||
        debitShorthandRegex.hasMatch(body)) {
      return SmsTransactionType.debit;
    } else if (creditKeywords.any((kw) => lowerBody.contains(kw)) ||
        creditShorthandRegex.hasMatch(body)) {
      return SmsTransactionType.credit;
    } else {
      return SmsTransactionType.unknown;
    }
  }
}
