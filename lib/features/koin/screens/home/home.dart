import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:koin/common/widgets/appbar/home_appbar.dart';
import 'package:koin/common/widgets/button/icon_button.dart';
import 'package:koin/common/widgets/button/simple_circular_icon_button.dart';
import 'package:koin/common/widgets/button/utility_icon_button.dart';
import 'package:koin/features/koin/controllers/all_transactions_controller.dart.dart';
import 'package:koin/features/koin/controllers/home_controller.dart';
import 'package:koin/features/koin/controllers/profile_controller.dart';
import 'package:koin/features/koin/controllers/transaction_cotroller.dart';
import 'package:koin/features/koin/screens/home/widgets/accounts.dart';
import 'package:koin/features/koin/screens/home/widgets/circular_budget_bar.dart';
import 'package:koin/features/koin/screens/home/widgets/dues_reminders.dart';
import 'package:koin/features/koin/screens/home/widgets/transactions_listvew.dart';
import 'package:koin/utils/constants/colors.dart';
import 'package:koin/utils/constants/sizes.dart';
import 'package:koin/utils/helpers/formatters.dart';
import 'package:koin/utils/helpers/helper_functions.dart';
import 'dart:math' as math;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final transactionController = TransactionController.instance;
    final allTransactionsController = Get.put(AllTransactionsController());

    return Scaffold(
      appBar: KHomeAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Circular Progress Bar
            KCircularBudgetProgress(),

            Divider(color: isDark ? TColors.darkerGrey : TColors.grey),
            //Transactions ListView
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        KIconButton(text: "Trends", icon: Iconsax.chart_1),
                        KIconButton(
                          text: "Categories",
                          icon: Iconsax.element_3,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Obx(
                    () => KTransactionsListView(
                      itemCount: 5,
                      transactions:
                          transactionController.currentMonthTransactions,
                      isLoading: transactionController.isLoading.value,
                    ),
                  ),
                  SizedBox(height: 15),
                  KDuesAndReminders(),
                  SizedBox(height: 15),
                  KAccounts(),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
