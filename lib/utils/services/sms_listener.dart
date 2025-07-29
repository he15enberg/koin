// services/sms_listener_service.dart
import 'package:easy_sms_receiver/easy_sms_receiver.dart';
import 'package:koin/utils/services/backgrond_sms.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:koin/data/isar/isar_service.dart';
import 'package:koin/features/authentication/models/transaction_model.dart';
import 'package:koin/utils/helpers/bank_directory.dart';
import 'package:koin/utils/helpers/sms_parser.dart';

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
          await IsarService.instance.saveTransaction(
            SmsTransactionModel.convertToIsarModel(transaction),
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
