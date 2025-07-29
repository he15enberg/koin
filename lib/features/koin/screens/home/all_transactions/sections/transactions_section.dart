import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koin/features/koin/controllers/transaction_cotroller.dart';
import 'package:koin/features/koin/screens/home/widgets/circular_budget_bar.dart';
import 'package:koin/features/koin/screens/home/widgets/transactions_listvew.dart';
import 'package:koin/utils/constants/sizes.dart';

class KTransactionsSection extends StatelessWidget {
  const KTransactionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionController = TransactionController.instance;

    return Column(
      children: [
        SizedBox(height: 15),
        KCircularBudgetProgress(),
        SizedBox(height: 15),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Obx(
            () => KTransactionsListView(
              isSectionExpandButtonNeeded: false,
              transactions: transactionController.currentMonthTransactions,
              isLoading: transactionController.isLoading.value,
            ),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
