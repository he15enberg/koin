import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koin/features/transactions/controllers/all_transactions_controller.dart';
import 'package:koin/features/transactions/controllers/transaction_controller.dart';
import 'package:koin/common/widgets/transaction/circular_budget_bar.dart';
import 'package:koin/common/widgets/transaction/transactions_listview.dart';
import 'package:koin/utils/constants/sizes.dart';

class KTransactionsSection extends StatelessWidget {
  const KTransactionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final allTranactionController = AllTransactionsController.instance;

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
              transactions: allTranactionController.monthTransactions,
              isLoading: allTranactionController.isLoading.value,
            ),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
