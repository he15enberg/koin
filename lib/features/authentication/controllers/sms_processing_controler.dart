import 'dart:isolate';
import 'package:get/get.dart';
import 'package:koin/data/isar/isar_service.dart';
import 'package:koin/data/isar/models/transaction_model.dart';
import 'package:koin/features/authentication/models/transaction_model.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:koin/utils/helpers/bank_directory.dart';
import 'package:koin/utils/helpers/sms_parser.dart';
import 'package:permission_handler/permission_handler.dart';

class SmsProcessingController extends GetxController {
  static SmsProcessingController get instance => Get.find();

  final RxList<SmsTransactionModel> transactions = <SmsTransactionModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString loadingMessage = ''.obs;
  final RxDouble progress = 0.0.obs;
  final RxBool isProcessingComplete = false.obs;

  final SmsQuery _query = SmsQuery();

  Future<void> processSmsMessages() async {
    try {
      isLoading.value = true;
      isProcessingComplete.value = false;
      progress.value = 0.0;

      loadingMessage.value = 'Checking for permissions...';

      final smsPermission = await Permission.sms.request();
      if (!smsPermission.isGranted) {
        loadingMessage.value = 'SMS permission denied';
        isLoading.value = false;
        return;
      }

      progress.value = 0.1;
      loadingMessage.value = 'Fetching all messages...';

      List<SmsMessage> allMessages = await _query.getAllSms;

      progress.value = 0.2;
      loadingMessage.value = 'Filtering bank messages...';

      final bankCodes = BankDirectory.getBankCodes();
      final bankMessages = allMessages.where((msg) {
        final sender = msg.address ?? '';
        return bankCodes.any(
          (code) => sender.toUpperCase().contains(code.toUpperCase()),
        );
      }).toList();

      progress.value = 0.3;
      loadingMessage.value =
          'Processing ${bankMessages.length} bank messages...';

      final List<SmsTransactionModel> processedTransactions = [];

      for (int i = 0; i < bankMessages.length; i++) {
        final msg = bankMessages[i];
        final transaction = SmsParser.parseTransaction(msg);

        if (transaction != null) {
          processedTransactions.add(transaction);
        }

        progress.value = 0.3 + (0.5 * (i + 1) / bankMessages.length);

        if (i % 50 == 0) {
          loadingMessage.value = 'Processing: ${i + 1}/${bankMessages.length}';
          await Future.delayed(Duration(milliseconds: 1));
        }
      }

      progress.value = 0.8;
      loadingMessage.value = 'Saving to database...';

      // Save to Isar database
      // Convert to Isar models before saving
      final isarTransactions = processedTransactions
          .map(SmsTransactionModel.convertToIsarModel)
          .toList();
      await IsarService.instance.saveTransactions(isarTransactions);
      progress.value = 0.9;
      loadingMessage.value = 'Finalizing...';

      transactions.assignAll(processedTransactions);

      progress.value = 1.0;
      loadingMessage.value =
          'Found ${processedTransactions.length} transactions';

      await Future.delayed(Duration(milliseconds: 500));

      isProcessingComplete.value = true;
      isLoading.value = false;
    } catch (e) {
      print('Error processing SMS: $e');
      loadingMessage.value = 'Error occurred';
      isLoading.value = false;
      progress.value = 0.0;
    }
  }

  void resetData() {
    transactions.clear();
    isLoading.value = false;
    loadingMessage.value = '';
    progress.value = 0.0;
    isProcessingComplete.value = false;
  }
}
