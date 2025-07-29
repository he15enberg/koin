import 'dart:isolate';
import 'package:get/get.dart';
import 'package:koin/data/isar/isar_service.dart';
import 'package:koin/data/isar/models/transaction_model.dart';
import 'package:koin/features/authentication/models/transaction_model.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:koin/utils/helpers/bank_directory.dart';
import 'package:koin/utils/helpers/sms_parser.dart';
import 'package:koin/utils/services/sms_listener.dart';
import 'package:permission_handler/permission_handler.dart';

class SmsProcessingController extends GetxController {
  static SmsProcessingController get instance => Get.find();

  final RxList<SmsTransactionModel> transactions = <SmsTransactionModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString loadingMessage = ''.obs;
  final RxDouble progress = 0.0.obs;
  final RxBool isProcessingComplete = false.obs; // Added missing property

  final SmsQuery _query = SmsQuery();

  Future<void> processSmsMessages() async {
    if (isLoading.value) return; // Prevent double processing

    try {
      isLoading.value = true;
      progress.value = 0.0;

      // Check permissions
      final smsPermission = await Permission.sms.request();
      if (!smsPermission.isGranted) {
        _showError('SMS permission denied');
        return;
      }

      progress.value = 0.1;
      loadingMessage.value = 'Fetching messages...';

      // Get all SMS
      List<SmsMessage> allMessages = await _query.getAllSms;

      progress.value = 0.3;
      loadingMessage.value = 'Filtering bank messages...';

      // Filter bank messages
      final bankCodes = BankDirectory.getBankCodes();
      final bankMessages = allMessages.where((msg) {
        final sender = msg.address ?? '';
        return bankCodes.any(
          (code) => sender.toUpperCase().contains(code.toUpperCase()),
        );
      }).toList();

      progress.value = 0.5;
      loadingMessage.value = 'Processing ${bankMessages.length} messages...';

      // Process in batches to avoid blocking
      final List<SmsTransactionModel> processedTransactions = [];
      const batchSize = 50;

      for (int i = 0; i < bankMessages.length; i += batchSize) {
        final batch = bankMessages.skip(i).take(batchSize);

        for (final msg in batch) {
          final transaction = SmsParser.parseTransaction(msg);
          if (transaction != null) {
            processedTransactions.add(transaction);
          }
        }

        progress.value = 0.5 + (0.3 * (i + batchSize) / bankMessages.length);
        await Future.delayed(Duration(milliseconds: 1)); // Prevent blocking
      }

      progress.value = 0.8;
      loadingMessage.value = 'Saving to database...';

      // Save to database
      final isarTransactions = processedTransactions
          .map(SmsTransactionModel.convertToIsarModel)
          .toList();
      await IsarService.instance.saveTransactions(isarTransactions);

      progress.value = 0.9;
      transactions.assignAll(processedTransactions);

      // Mark processing complete and start listener
      await IsarService.instance.setSmsProcessingCompleted();
      await SmsListenerService.initialize();

      progress.value = 1.0;
      loadingMessage.value =
          'Found ${processedTransactions.length} transactions';

      await Future.delayed(Duration(milliseconds: 500));
      isProcessingComplete.value = true; // Set processing complete
      isLoading.value = false;
    } catch (e) {
      _showError('Error processing SMS: $e');
    }
  }

  void _showError(String message) {
    print(message);
    loadingMessage.value = message;
    isLoading.value = false;
    progress.value = 0.0;
  }

  void resetData() {
    transactions.clear();
    isLoading.value = false;
    loadingMessage.value = '';
    progress.value = 0.0;
    isProcessingComplete.value = false; // Reset processing complete
  }

  Future<void> completeProcessingAndStartListener() async {
    try {
      await IsarService.instance.setSmsProcessingCompleted();
      final success = await SmsListenerService.initialize();

      if (success) {
        print('Real-time SMS monitoring started successfully');
      } else {
        print('Failed to start real-time SMS monitoring');
      }
    } catch (e) {
      print('Error completing SMS processing setup: $e');
    }
  }
}
