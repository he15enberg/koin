import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:koin/features/koin/controllers/all_transactions_controller.dart.dart';
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

    return Container(
      height: THelperFunctions.screenHeight() * 0.25,
      child: Row(
        children: [
          // Pie Chart
          Expanded(
            flex: 2,
            child: PieChart(
              PieChartData(
                sections: categoriesData.entries.map((entry) {
                  final count = entry.value.length;
                  final percent = (count / total * 100);

                  return PieChartSectionData(
                    value: count.toDouble(),
                    color: KFormatters.getCategoryInfo(entry.key)["color"],
                    radius: 60,
                    showTitle: false,
                  );
                }).toList(),
                centerSpaceRadius: 80,
                sectionsSpace: 2,
                startDegreeOffset: -90,
              ),
            ),
          ),

          // Legend
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: categoriesData.entries.map((entry) {
                final count = entry.value.length;
                final percent = (count / total * 100).toStringAsFixed(1);
                final categoryInfo = KFormatters.getCategoryInfo(entry.key);

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
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
                          '${entry.key} $percent%',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
