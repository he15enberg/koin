import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:koin/common/widgets/button/section_expand_button.dart';
import 'package:koin/common/widgets/button/simple_circular_icon_button.dart';
import 'package:koin/common/widgets/button/utility_icon_button.dart';
import 'package:koin/data/isar/models/transaction_model.dart';
import 'package:koin/features/koin/controllers/transaction_cotroller.dart';
import 'package:koin/features/koin/screens/home/all_transactions/all_transaction.dart';
import 'package:koin/features/koin/screens/transaction/transaction_screen.dart';
import 'package:koin/utils/constants/colors.dart';
import 'package:koin/utils/helpers/formatters.dart';
import 'package:koin/utils/helpers/helper_functions.dart';

class KTransactionsListView extends StatelessWidget {
  const KTransactionsListView({
    super.key,
    this.itemCount,
    required this.transactions,
    required this.isLoading,
    this.isSectionExpandButtonNeeded = true,
  });
  final bool isSectionExpandButtonNeeded;
  final int? itemCount;
  final RxList<TransactionModel> transactions;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Container(
      decoration: BoxDecoration(
        color: isDark ? TColors.dark : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Transactions",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: THelperFunctions.getThemeModeColor(),
                  ),
                ),
                const KUtilityIconButton(text: "Add", icon: Iconsax.add_circle),
              ],
            ),
          ),

          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else if (transactions.isEmpty)
            const Center(child: Text('No transactions found'))
          else
            ListView.builder(
              itemCount: itemCount ?? transactions.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final transaction = transactions[index];

                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TransactionScreen(transaction: transaction),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                      border: index == ((itemCount ?? transactions.length) - 1)
                          ? null
                          : Border(
                              bottom: BorderSide(
                                color: isDark
                                    ? TColors.darkerGrey
                                    : TColors.grey,
                              ),
                            ),
                    ),
                    child: Row(
                      children: [
                        KSimpleCircularIconButton(
                          padding: 5,
                          iconsize: 20,
                          icon: KFormatters.getCategoryInfo(
                            transaction.category,
                          )["icon"],
                          backgroundColor: KFormatters.getCategoryInfo(
                            transaction.category,
                          )["color"],
                          iconColor: Colors.white,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: Text(
                              transaction.merchantName.isEmpty
                                  ? 'Unknown Merchant'
                                  : transaction.merchantName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text(
                                  KFormatters.formatToRupees(
                                    transaction.amount,
                                  ),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const SizedBox(width: 5),
                                KSimpleCircularIconButton(
                                  iconsize: 15,
                                  icon:
                                      transaction.smsType ==
                                          TransactionType.credit
                                      ? Icons.south_west
                                      : transaction.smsType ==
                                            TransactionType.debit
                                      ? Icons.north_east
                                      : Icons.close,
                                ),
                              ],
                            ),
                            Text(
                              KFormatters.formatToShortDate(
                                transaction.dateTime,
                              ),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

          isSectionExpandButtonNeeded
              ? KSectionExpandButton(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllTransactionsScreen(),
                    ),
                  ),
                )
              : Container(),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
