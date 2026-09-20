// services/sms_listener_service.dart
import 'package:easy_sms_receiver/easy_sms_receiver.dart';
import 'package:koin/services/sms_engine/background_sms_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:koin/data/local/repositories/transaction_repository.dart';
import 'package:koin/services/sms_engine/sms_transaction_model.dart';
import 'package:koin/services/sms_engine/bank_directory.dart';
import 'package:koin/services/sms_engine/sms_parser.dart';

class SmsListenerService {
  static final EasySmsReceiver _receiver = EasySmsReceiver.instance;
  static bool _isListening = false;

  static Future<bool> initialize() async {
    try {
      if (_isListening) {
        print('SMS listener already active');
        return true;
      }

      final permissionStatus = await Permission.sms.request();
      if (!permissionStatus.isGranted) {
        print('SMS permission denied');
        return false;
      }

      _receiver.listenIncomingSms(
        onNewMessage: (message) async {
          await _processSms(message);
        },
      );

      _isListening = true;
      print('SMS listener initialized successfully');
      return true;
    } catch (e) {
      print('Error initializing SMS listener: $e');
      return false;
    }
  }

  static Future<void> _processSms(dynamic message) async {
    try {
      final sender = message.address ?? '';
      final bankCodes = BankDirectory.getBankCodes();

      if (bankCodes.any(
        (code) => sender.toUpperCase().contains(code.toUpperCase()),
      )) {
        final transaction = SmsParser.parseTransaction(message);
        if (transaction != null) {
          await TransactionRepository.instance.saveTransaction(
            SmsTransactionModel.toTransactionModel(transaction),
          );
          print('Transaction saved: ${transaction.merchantName}');
        }
      }
    } catch (e) {
      print('Error processing SMS: $e');
    }
  }

  static void stopListening() {
    _receiver.stopListenIncomingSms();
    _isListening = false;
  }

  static bool get isListening => _isListening;
}
