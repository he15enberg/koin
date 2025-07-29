import 'package:get/get.dart';
import 'package:koin/data/isar/isar_service.dart';
import 'package:koin/data/isar/models/transaction_model.dart';

class TransactionController extends GetxController {
  static TransactionController get instance => Get.find();

  final RxList<TransactionModel> transactions = <TransactionModel>[].obs;
  final RxList<TransactionModel> currentMonthTransactions =
      <TransactionModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxDouble currentMonthSpend = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadAllData();
  }

  Future<void> loadAllData() async {
    final allTransactions = await IsarService.instance.getAllTransactions();
    final monthTransactions = await IsarService.instance
        .getCurrentMonthTransactions();
    print(monthTransactions.length);
    transactions.assignAll(allTransactions);
    currentMonthTransactions.assignAll(monthTransactions);

    currentMonthSpend.value = monthTransactions
        .where((t) => t.smsType == TransactionType.debit)
        .fold(0.0, (sum, t) => sum + t.amount);

    isLoading.value = false;
  }
}
