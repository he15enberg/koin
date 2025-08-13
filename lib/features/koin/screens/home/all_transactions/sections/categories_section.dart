import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:koin/common/widgets/button/simple_circular_icon_button.dart';
import 'package:koin/features/koin/controllers/all_transactions_controller.dart.dart';
import 'package:koin/utils/constants/colors.dart';
import 'package:koin/utils/helpers/formatters.dart';
import 'package:koin/utils/helpers/helper_functions.dart';

class KCategoriesSection extends StatelessWidget {
  const KCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final allTranactionController = AllTransactionsController.instance;
    final categoriesData = allTranactionController.getCategoriesData();
    final total = categoriesData.values.fold<int>(
      0,
      (sum, list) => sum + list.length,
    );
    final isDark = THelperFunctions.isDarkMode(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: THelperFunctions.screenHeight() * 0.25,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                // Pie Chart
                Expanded(
                  flex: 5,
                  child: PieChart(
                    PieChartData(
                      sections: categoriesData.entries.map((entry) {
                        final count = entry.value.length;
                        final percent = (count / total * 100);

                        return PieChartSectionData(
                          value: count.toDouble(),
                          color: KFormatters.getCategoryInfo(
                            entry.key,
                          )["color"],
                          radius: 30,
                          showTitle: false,
                        );
                      }).toList(),
                      centerSpaceRadius: 50,
                      sectionsSpace: 0,
                      startDegreeOffset: -90,
                    ),
                  ),
                ),

                // Legend
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: categoriesData.entries.map((entry) {
                      final count = entry.value.length;
                      final percent = (count / total * 100).toStringAsFixed(1);
                      final categoryInfo = KFormatters.getCategoryInfo(
                        entry.key,
                      );
                      return Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: categoryInfo["color"],
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${(entry.key.isNotEmpty ? entry.key.capitalize : "Unknown")} $percent%',
                              style: Theme.of(context).textTheme.labelMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: categoriesData.length,
            itemBuilder: (context, index) {
              final entry = categoriesData.entries.elementAt(index);
              final count = entry.value.length;
              final name = entry.key.isNotEmpty
                  ? entry.key.capitalize
                  : "Unknown";
              final totalAmount = entry.value.fold<double>(
                0,
                (sum, txn) => sum + txn.amount,
              );
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: isDark ? TColors.dark : Colors.white,
                  border: Border.all(
                    color: isDark ? TColors.darkestGrey : TColors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  spacing: 7.5,
                  children: [
                    KSimpleCircularIconButton(
                      iconsize: 20,
                      padding: 7,
                      backgroundColor: KFormatters.getCategoryInfo(
                        entry.key,
                      )["color"],
                      icon: KFormatters.getCategoryInfo(entry.key)["icon"],
                      iconColor: Colors.white,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name!,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          "${count} spends",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          KFormatters.formatToRupees(totalAmount),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          "Set Budget >",
                          style: Theme.of(context).textTheme.labelMedium!
                              .copyWith(color: TColors.success),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
