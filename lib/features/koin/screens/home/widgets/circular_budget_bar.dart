import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koin/features/koin/controllers/home_controller.dart';
import 'package:koin/features/koin/controllers/transaction_cotroller.dart';
import 'package:koin/utils/constants/colors.dart';
import 'package:koin/utils/constants/sizes.dart';
import 'package:koin/utils/helpers/formatters.dart';
import 'package:koin/utils/helpers/helper_functions.dart';

class KCircularBudgetProgress extends StatelessWidget {
  const KCircularBudgetProgress({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final transactionController = TransactionController.instance;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
      child: Column(
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Spent in ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextSpan(
                  text: "July",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 15.0),
          Container(
            height: THelperFunctions.screenHeight() * 0.25,
            width: THelperFunctions.screenWidth(),
            child: DashedCircularProgressBar.aspectRatio(
              aspectRatio: 1, // width ÷ height

              valueNotifier: HomeController.valueNotifier,
              progress: 75,
              startAngle: 0, // Start from top
              sweepAngle: 360, // Full circle
              foregroundColor: TColors.primary,
              backgroundColor: const Color(0xffeeeeee),
              foregroundStrokeWidth: 12.5,
              backgroundStrokeWidth: 12.5,
              animation: true,
              seekSize: 5,
              seekColor: const Color(0xffeeeeee),

              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: TColors.grey,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.arrow_outward, color: Colors.black),
                        ),
                        SizedBox(height: 5),
                        Obx(
                          () => Text(
                            KFormatters.formatToRupees(
                              transactionController.currentMonthSpend.value,
                            ),
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Income (Jun)\n \$25,000"),
                Container(
                  width: 1,
                  height: 30,
                  color: isDark ? TColors.darkerGrey : TColors.grey,
                ),
                Text("Set monthly\nbudget"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
