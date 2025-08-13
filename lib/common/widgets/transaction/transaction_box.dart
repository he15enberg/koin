import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:koin/common/widgets/button/simple_circular_icon_button.dart';
import 'package:koin/data/isar/models/transaction_model.dart';
import 'package:koin/utils/constants/colors.dart';
import 'package:koin/utils/helpers/formatters.dart';

class KTransactionBox extends StatelessWidget {
  final String date;
  final String merchantName;
  final String visitsText;
  final TransactionType smsType;
  final String amount;
  final String category;
  final bool isDark;

  const KTransactionBox({
    super.key,
    required this.date,
    required this.merchantName,
    required this.visitsText,
    required this.smsType,
    required this.amount,
    required this.category,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? TColors.dark : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            spacing: 10,
            children: [
              Expanded(
                child: Text(
                  merchantName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 5,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: isDark ? TColors.darkestGrey : TColors.softGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 5,
                      children: [
                        Text(visitsText),
                        const Icon(Icons.bar_chart_rounded, size: 17.5),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              KSimpleCircularIconButton(
                iconsize: 15,
                icon: smsType == TransactionType.credit
                    ? Icons.south_west
                    : smsType == TransactionType.debit
                    ? Icons.north_east
                    : Icons.close,
              ),
              Text(amount, style: Theme.of(context).textTheme.headlineLarge),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              color: isDark ? TColors.darkestGrey : TColors.softGrey,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                KSimpleCircularIconButton(
                  padding: 5,
                  iconsize: 20,
                  icon: KFormatters.getCategoryInfo(category)["icon"],
                  backgroundColor: KFormatters.getCategoryInfo(
                    category,
                  )["color"],
                  iconColor: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.5),
                  child: Text(
                    (category.isNotEmpty ? category.capitalize : "Unknown")!,
                    style: Theme.of(context).textTheme.titleLarge!,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(date, style: Theme.of(context).textTheme.bodyMedium!),
        ],
      ),
    );
  }
}
