import 'package:get/get.dart';
import 'package:koin/data/local/repositories/transaction_repository.dart';
import 'package:koin/data/local/models/transaction_model.dart';

class TransactionController extends GetxController {
  static TransactionController get instance => Get.find();

  final RxBool isTransactionExpense = true.obs;

  final RxList<TransactionModel> currentMonthTransactions =
      <TransactionModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxDouble currentMonthSpend = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadCurrentMonthData();
  }

  Future<void> loadCurrentMonthData() async {
    final monthTransactions = await TransactionRepository.instance
        .getCurrentMonthTransactions();

    currentMonthTransactions.assignAll(monthTransactions);
    currentMonthSpend.value = monthTransactions
        .where((t) => t.smsType == TransactionType.debit)
        .fold(0.0, (sum, t) => sum + t.amount);

    isLoading.value = false;
  }

  Future<void> refreshData() async {
    await loadCurrentMonthData();
  }
}
