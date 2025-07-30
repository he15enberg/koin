import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:koin/data/isar/isar_service.dart';
import 'package:koin/data/isar/models/transaction_model.dart';
import 'package:koin/features/koin/screens/home/all_transactions/sections/categories_section.dart';
import 'package:koin/features/koin/screens/home/all_transactions/sections/merchants_section.dart';
import 'package:koin/features/koin/screens/home/all_transactions/sections/transactions_section.dart';

class AllTransactionsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static AllTransactionsController get instance => Get.find();

  final tabs = [
    {"name": "Transactions", "section": KTransactionsSection()},
    {"name": "Categories", "section": KCategoriesSection()},
    {"name": "Merchants", "section": KMerchantSection()},
  ];

  final RxBool isGraphOpen = false.obs;
  final RxList<TransactionModel> allTransactions = <TransactionModel>[].obs;
  final RxList<TransactionModel> monthTransactions = <TransactionModel>[].obs;
  final Rx<String> selectedMonth = DateFormat(
    'yyyy-MM',
  ).format(DateTime.now()).obs;
  final RxBool isLoading = true.obs;

  late AnimationController animationController;
  late Animation<double> sizeAnimation;

  @override
  void onInit() {
    super.onInit();
    _initializeAnimation();
    loadAllData();
  }

  void toggleGraph() {
    isGraphOpen.value = !isGraphOpen.value;
    if (isGraphOpen.value) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  void _initializeAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    sizeAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    );
  }

  Future<void> loadAllData() async {
    isLoading.value = true;

    // Fetch all transactions once
    final transactions = await IsarService.instance.getAllTransactions();
    allTransactions.assignAll(transactions);

    // Load current month
    _filterCurrentMonth();
    isLoading.value = false;
  }

  void changeMonth(String monthKey) {
    selectedMonth.value = monthKey;
    _filterByMonth(monthKey);
  }

  void _filterCurrentMonth() {
    _filterByMonth(selectedMonth.value);
  }

  void _filterByMonth(String monthKey) {
    monthTransactions.assignAll(
      allTransactions
          .where((t) => DateFormat('yyyy-MM').format(t.dateTime) == monthKey)
          .toList(),
    );
  }

  // Category data for pie chart
  Map<String, List<TransactionModel>> getCategoriesData() {
    final Map<String, List<TransactionModel>> grouped = {};
    for (final transaction in monthTransactions) {
      grouped.putIfAbsent(transaction.category, () => []).add(transaction);
    }
    return grouped;
  }

  // Merchant data
  Map<String, List<TransactionModel>> getMerchantsData() {
    final Map<String, List<TransactionModel>> grouped = {};
    for (final transaction in monthTransactions) {
      grouped.putIfAbsent(transaction.merchantName, () => []).add(transaction);
    }
    return grouped;
  }

  // Get available months for dropdown
  // Get available months for dropdown
  List<Map<String, dynamic>> get availableMonths {
    final currentYear = DateTime.now().year;
    final monthGroups = <String, List<TransactionModel>>{};

    // Group by month
    for (final t in allTransactions) {
      final key = DateFormat('yyyy-MM').format(t.dateTime);
      monthGroups.putIfAbsent(key, () => []).add(t);
    }

    return monthGroups.entries.map((entry) {
        final date = DateTime.parse('${entry.key}-01');
        final isCurrentYear = date.year == currentYear;

        final transactions = entry.value;
        final debitTotal = transactions
            .where((t) => t.smsType == TransactionType.debit)
            .fold(0.0, (sum, t) => sum + t.amount);
        final creditTotal = transactions
            .where((t) => t.smsType == TransactionType.credit)
            .fold(0.0, (sum, t) => sum + t.amount);

        return {
          "key": entry.key,
          "month": isCurrentYear
              ? DateFormat('MMM').format(date)
              : DateFormat("MMM''yy").format(date),
          "debit_total": debitTotal,
          "credit_total": creditTotal,
        };
      }).toList()
      ..sort((a, b) => (b["key"] as String).compareTo(a["key"] as String));
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
