enum TransactionType { credit, debit, unknown }

class TransactionModel {
  int? id;

  final String bankCode;
  final double amount;
  final String bankName;
  final String bankPhoto;
  final String accountLastFourDigits;
  final String merchantName;
  final DateTime dateTime;
  final String referenceNumber;
  final TransactionType smsType;
  final String messageAddress;
  final String messageBody;
  final String? merchantPhoto;
  final String category;

  TransactionModel({
    this.id,
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

  /// Same real SMS reprocessed by both the foreground listener and the
  /// background service (or reprocessed on a rescan) collapses to the same
  /// key, so a UNIQUE constraint on this column makes re-saving it a no-op
  /// instead of a duplicate row.
  String get dedupKey =>
      '$messageAddress|$amount|$referenceNumber|'
      '${dateTime.millisecondsSinceEpoch ~/ 60000}';

  Map<String, Object?> toMap() {
    return {
      if (id != null) 'id': id,
      'bank_code': bankCode,
      'amount': amount,
      'bank_name': bankName,
      'bank_photo': bankPhoto,
      'account_last_four_digits': accountLastFourDigits,
      'merchant_name': merchantName,
      'date_time': dateTime.millisecondsSinceEpoch,
      'reference_number': referenceNumber,
      'sms_type': smsType.name,
      'message_address': messageAddress,
      'message_body': messageBody,
      'merchant_photo': merchantPhoto,
      'category': category,
      'dedup_key': dedupKey,
    };
  }

  factory TransactionModel.fromMap(Map<String, Object?> map) {
    return TransactionModel(
      id: map['id'] as int?,
      bankCode: map['bank_code'] as String,
      amount: (map['amount'] as num).toDouble(),
      bankName: map['bank_name'] as String,
      bankPhoto: map['bank_photo'] as String,
      accountLastFourDigits: map['account_last_four_digits'] as String,
      merchantName: map['merchant_name'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['date_time'] as int),
      referenceNumber: map['reference_number'] as String,
      smsType: TransactionType.values.byName(map['sms_type'] as String),
      messageAddress: map['message_address'] as String,
      messageBody: map['message_body'] as String,
      merchantPhoto: map['merchant_photo'] as String?,
      category: map['category'] as String? ?? '',
    );
  }
}
