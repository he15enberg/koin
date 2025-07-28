import 'dart:typed_data';

import 'package:koin/data/isar/models/transaction_model.dart';

class SmsTransactionModel {
  final String bankCode;
  final String bankName;
  final String bankPhoto;
  final double amount;
  final String accountLastFourDigits;
  final String merchantName;
  final DateTime dateTime;
  final String referenceNumber;
  final SmsTransactionType smsType;
  final String messageAddress;
  final String messageBody;
  final String? location;
  final Uint8List? merchantPhoto;
  final String? category;

  SmsTransactionModel({
    required this.bankCode,
    required this.bankName,
    required this.bankPhoto,
    required this.amount,
    required this.accountLastFourDigits,
    required this.merchantName,
    required this.dateTime,
    required this.referenceNumber,
    required this.smsType,
    required this.messageAddress,
    required this.messageBody,
    this.merchantPhoto,
    this.location,
    this.category,
  });

  @override
  String toString() {
    return 'SmsTransactionModel(bankCode: $bankCode, bankName: $bankName, amount: $amount, smsType: $smsType, category: $category)';
  }

  static TransactionModel convertToIsarModel(
    SmsTransactionModel smsTransaction,
  ) {
    return TransactionModel(
      bankCode: smsTransaction.bankCode,
      amount: smsTransaction.amount,
      bankName: smsTransaction.bankName,
      bankPhoto: smsTransaction.bankPhoto,
      accountLastFourDigits: smsTransaction.accountLastFourDigits,
      merchantName: smsTransaction.merchantName,
      dateTime: smsTransaction.dateTime,
      referenceNumber: smsTransaction.referenceNumber,
      smsType: TransactionType.values[smsTransaction.smsType.index],
      messageAddress: smsTransaction.messageAddress,
      messageBody: smsTransaction.messageBody,
      merchantPhoto: null,
      category: smsTransaction.category ?? '',
    );
  }
}

enum SmsTransactionType { credit, debit, unknown }
