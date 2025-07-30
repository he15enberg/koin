import 'package:animated_expand/animated_expand.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:koin/common/styles/tab_indicator.dart';
import 'package:koin/common/widgets/appbar/screen_appbar.dart';
import 'package:koin/common/widgets/button/simple_circular_icon_button.dart';
import 'package:koin/features/koin/controllers/all_transactions_controller.dart.dart';
import 'package:koin/features/koin/screens/home/all_transactions/sections/transactions_section.dart';
import 'package:koin/features/koin/screens/home/widgets/circular_budget_bar.dart';
import 'package:koin/utils/constants/colors.dart';
import 'package:koin/utils/helpers/formatters.dart';
import 'package:koin/utils/helpers/helper_functions.dart';

class AllTransactionsScreen extends StatelessWidget {
  const AllTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AllTransactionsController.instance;
    final isDark = THelperFunctions.isDarkMode(context);

    return DefaultTabController(
      length: controller.tabs.length,
      child: Scaffold(
        appBar: KScreenAppBar(
          child: Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "All Transactions",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        GestureDetector(
                          onTap: controller.toggleGraph,
                          child: Row(
                            children: [
                              Text(
                                "Jul",
                                style: Theme.of(
                                  context,
                                ).textTheme.labelMedium!.copyWith(fontSize: 14),
                              ),
                              Icon(
                                controller.isGraphOpen.value
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                                color: isDark ? TColors.darkGrey : TColors.dark,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    spacing: 7.5,
                    children: [
                      KSimpleCircularIconButton(
                        icon: Iconsax.filter,
                        iconsize: 17.5,
                        padding: 7,
                      ),
                      KSimpleCircularIconButton(
                        icon: Iconsax.export_3,
                        iconsize: 17.5,
                        padding: 7,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            SizeTransition(
              sizeFactor: controller.sizeAnimation,
              axisAlignment: -1.0,
              child: Container(
                height: 150,
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    height: 150,
                    width: controller.availableMonths.length * 50.0,
                    padding: EdgeInsets.all(16),
                    child: Obx(
                      () => BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          barTouchData: BarTouchData(
                            enabled: true,
                            handleBuiltInTouches: false,
                            touchCallback:
                                (FlTouchEvent event, barTouchResponse) {
                                  if (event is FlTapUpEvent &&
                                      barTouchResponse?.spot != null) {
                                    final index = barTouchResponse!
                                        .spot!
                                        .touchedBarGroupIndex;
                                    final month = controller
                                        .availableMonths
                                        .reversed
                                        .toList()[index];
                                    // Change selected month
                                    controller.changeMonth(month["key"]);
                                  }
                                },
                          ),

                          barGroups: controller.availableMonths.reversed
                              .toList()
                              .asMap()
                              .entries
                              .map((entry) {
                                final index = entry.key;
                                final month = entry.value;
                                final isSelected =
                                    controller.selectedMonth.value ==
                                    month["key"];

                                return BarChartGroupData(
                                  x: index,
                                  barRods: [
                                    BarChartRodData(
                                      borderRadius: BorderRadius.circular(5),
                                      toY: month["debit_total"],
                                      color: isSelected
                                          ? TColors.primary
                                          : TColors.primary.withOpacity(0.5),
                                      width: 15,
                                    ),
                                  ],
                                  // Add background for selected bar
                                  barsSpace: 4,
                                );
                              })
                              .toList(),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  final month = controller
                                      .availableMonths
                                      .reversed
                                      .toList()[value.toInt()];
                                  return Text(
                                    month["month"],
                                    style: TextStyle(fontSize: 12),
                                  );
                                },
                              ),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  final month = controller
                                      .availableMonths
                                      .reversed
                                      .toList()[value.toInt()];
                                  return Text(
                                    KFormatters.formatAmountToKRupees(
                                      month["debit_total"],
                                    ),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          gridData: FlGridData(show: false),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            TabBar(
              isScrollable: false,
              dividerColor: isDark ? TColors.dark : TColors.white,
              indicatorColor: TColors.primary,
              labelColor: TColors.primary,
              indicator: KBlurryTabIndicatorDecoration(color: TColors.primary),
              indicatorSize: TabBarIndicatorSize.tab,
              padding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              indicatorPadding: EdgeInsets.zero,
              labelStyle: Theme.of(
                context,
              ).textTheme.labelMedium!.copyWith(fontSize: 13),
              unselectedLabelStyle: Theme.of(
                context,
              ).textTheme.labelMedium!.copyWith(fontSize: 13),
              tabs: controller.tabs
                  .map((tab) => Tab(text: tab["name"] as String))
                  .toList(),
            ),
            Expanded(
              child: TabBarView(
                children: controller.tabs.map((label) {
                  return SingleChildScrollView(
                    child: label["section"] as Widget,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
