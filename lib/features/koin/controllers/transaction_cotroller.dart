import 'package:get/get.dart';
import 'package:koin/data/isar/isar_service.dart';
import 'package:koin/data/isar/models/transaction_model.dart';

class TransactionController extends GetxController {
  static TransactionController get instance => Get.find();

  final RxList<TransactionModel> currentMonthTransactions =
      <TransactionModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxDouble currentMonthSpend = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadCurrentMonthData();
  }

  Future<void> loadCurrentMonthData() async {
    final monthTransactions = await IsarService.instance
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
