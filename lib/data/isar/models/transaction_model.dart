import 'package:isar/isar.dart';

part 'transaction_model.g.dart'; // Add this line

@collection
class TransactionModel {
  Id id = Isar.autoIncrement; // Add this line

  late String bankCode;
  late double amount;
  late String bankName;
  late String bankPhoto;
  late String accountLastFourDigits;
  late String merchantName;
  late DateTime dateTime;
  late String referenceNumber;
  @enumerated
  late TransactionType smsType;
  late String messageAddress;
  late String messageBody;
  String? merchantPhoto;
  late String category;

  // Constructor remains the same
  TransactionModel({
    required this.bankCode,
    required this.amount,
    required this.bankName,
    required this.bankPhoto,
    required this.accountLastFourDigits,
    required this.merchantName,
    required this.dateTime,
    required this.referenceNumber,
    required this.smsType,
    required this.messageAddress,
    required this.messageBody,
    this.merchantPhoto,
    required this.category,
  });
}

enum TransactionType { credit, debit, unknown }
