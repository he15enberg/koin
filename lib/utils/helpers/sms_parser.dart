import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:koin/features/authentication/models/transaction_model.dart';
import 'package:koin/utils/helpers/bank_directory.dart';
import 'package:koin/utils/helpers/cateogry_classifier.dart';
import 'package:koin/utils/helpers/merchant_name.dart';

class SmsParser {
  static SmsTransactionModel? parseTransaction(SmsMessage msg) {
    try {
      final body = msg.body ?? '';
      final sender = msg.address ?? '';

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

      // Extract amount using regex
      final amountRegex = RegExp(r'Rs\.?\s*(\d+(?:,\d+)*(?:\.\d+)?)');
      final amountMatch = amountRegex.firstMatch(body);
      final amount = amountMatch != null
          ? double.tryParse(amountMatch.group(1)!.replaceAll(',', '')) ?? 0.0
          : 0.0;

      // Extract account last 4 digits
      final accountRegex = RegExp(r'[xX*]{4,}\d{4}|\d{4}');
      final accountMatch = accountRegex.firstMatch(body);
      final accountLastFour =
          accountMatch?.group(0)?.replaceAll(RegExp(r'[xX*]'), '') ?? '';

      final SmsTransactionType smsType = SmsParserHelper.getTransactionType(
        body,
      );

      // Extract merchant name (simple approach - text after "at" or "to")
      //

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
        dateTime: msg.date ?? DateTime.now(),
        referenceNumber: referenceNumber,
        smsType: smsType,
        messageAddress: sender,
        messageBody: body,
        merchantPhoto: null,
        category: category, // Add the classified category
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
  ];

  static const List<String> creditKeywords = [
    'credited',
    'credit',
    'received',
    'deposit',
    'added',
  ];
  static SmsTransactionType getTransactionType(String body) {
    final lowerBody = body.toLowerCase();

    if (debitKeywords.any((kw) => lowerBody.contains(kw))) {
      return SmsTransactionType.debit;
    } else if (creditKeywords.any((kw) => lowerBody.contains(kw))) {
      return SmsTransactionType.credit;
    } else {
      return SmsTransactionType.unknown;
    }
  }
}
