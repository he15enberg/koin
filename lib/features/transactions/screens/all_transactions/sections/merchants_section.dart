import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:koin/common/widgets/button/simple_circular_icon_button.dart';
import 'package:koin/features/transactions/controllers/all_transactions_controller.dart';
import 'package:koin/utils/constants/colors.dart';
import 'package:koin/utils/helpers/formatters.dart';
import 'package:koin/utils/helpers/helper_functions.dart';

class KMerchantSection extends StatelessWidget {
  const KMerchantSection({super.key});

  @override
  Widget build(BuildContext context) {
    final merchantsData = AllTransactionsController.instance.getMerchantsData();
    final isDark = THelperFunctions.isDarkMode(context);

    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 10),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: merchantsData.length,
      itemBuilder: (context, index) {
        final entry = merchantsData.entries.elementAt(index);
        final totalAmount = entry.value.fold<double>(
          0,
          (sum, txn) => sum + txn.amount,
        );
        final merchantName = entry.key.isNotEmpty
            ? entry.key
            : "Unknown Merchant";
        final count = entry.value.length;

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
                backgroundColor: TColors.primary,
                icon: Iconsax.shop,
                iconColor: Colors.white,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      merchantName!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      "${count} spends",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
              Text(
                KFormatters.formatToRupees(totalAmount),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        );
      },
    );
  }
}
