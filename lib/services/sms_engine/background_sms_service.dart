// services/background_sms_service.dart
import 'dart:ui';

import 'package:easy_sms_receiver/easy_sms_receiver.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:koin/data/local/app_database.dart';
import 'package:koin/data/local/repositories/transaction_repository.dart';
import 'package:koin/services/sms_engine/sms_transaction_model.dart';
import 'package:koin/services/sms_engine/bank_directory.dart';
import 'package:koin/services/sms_engine/sms_parser.dart';

@pragma('vm:entry-point')
class BackgroundSmsService {
  @pragma('vm:entry-point')
  static Future<void> initializeService() async {
    final service = FlutterBackgroundService();

    await service.configure(
      iosConfiguration: IosConfiguration(),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        isForegroundMode: true,
        autoStart: true,
        autoStartOnBoot: true,
      ),
    );
  }

  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();

    try {
      // Register the database + transaction repository in this isolate
      if (!Get.isRegistered<AppDatabase>()) {
        await Get.putAsync(() => AppDatabase().init(), permanent: true);
      }
      if (!Get.isRegistered<TransactionRepository>()) {
        Get.put(TransactionRepository(), permanent: true);
      }

      final plugin = EasySmsReceiver.instance;
      plugin.listenIncomingSms(
        onNewMessage: (message) async {
          await _processIncomingSms(message, service);
        },
      );

      print('Background SMS service started successfully');
    } catch (e) {
      print('Error starting background SMS service: $e');
    }
  }

  @pragma('vm:entry-point')
  static Future<void> _processIncomingSms(
    dynamic message,
    ServiceInstance service,
  ) async {
    try {
      final sender = message.address ?? '';
      final bankCodes = BankDirectory.getBankCodes();

      if (bankCodes.any(
        (code) => sender.toUpperCase().contains(code.toUpperCase()),
      )) {
        final transaction = SmsParser.parseTransaction(message);

        if (transaction != null) {
          await Get.find<TransactionRepository>().saveTransaction(
            SmsTransactionModel.toTransactionModel(transaction),
          );

          // if (service is AndroidServiceInstance) {
          //   service.setForegroundNotificationInfo(
          //     title: 'Bank Transaction',
          //     content: '${transaction.merchantName}: ₹${transaction.amount}',
          //   );
          // }
        }
      }
    } catch (e) {
      print('Error processing background SMS: $e');
    }
  }

  @pragma('vm:entry-point')
  static Future<void> stopService() async {
    final service = FlutterBackgroundService();
    service.invoke('stop');
    EasySmsReceiver.instance.stopListenIncomingSms();
  }
}
