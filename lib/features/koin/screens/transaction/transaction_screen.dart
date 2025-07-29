import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:koin/common/widgets/appbar/screen_appbar.dart';
import 'package:koin/common/widgets/button/simple_circular_icon_button.dart';
import 'package:koin/data/isar/models/transaction_model.dart';
import 'package:koin/utils/constants/colors.dart';
import 'package:koin/utils/helpers/formatters.dart';
import 'package:koin/utils/helpers/helper_functions.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key, required this.transaction});
  final TransactionModel transaction;
  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: KScreenAppBar(
        text:
            "${transaction.smsType.name.toString().capitalize ?? "Unknown"} Transaction",
        action: KSimpleCircularIconButton(
          icon: Iconsax.menu,
          iconsize: 17.5,
          padding: 7,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 10,
                ),

                decoration: BoxDecoration(
                  color: isDark ? TColors.darkerGrey : TColors.grey,
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
                            transaction.merchantName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            spacing: 5,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 7.5,
                                ),

                                decoration: BoxDecoration(
                                  color: TColors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 5,
                                  children: [
                                    Text("62 visits"),
                                    Icon(Icons.bar_chart_rounded, size: 17.5),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_outward, size: 15),
                        Text(
                          KFormatters.formatToRupees(transaction.amount),
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                        Text("Food and Drinks"),
                      ],
                    ),
                    Text(
                      KFormatters.formatDateTimeToLongString(
                        transaction.dateTime,
                      ),
                    ),
                  ],
                ),
              ),
              Text(transaction.referenceNumber ?? "Unknown"),
              Text(transaction.messageAddress ?? "Unknown"),
              Text(transaction.messageBody ?? "Unknown"),
            ],
          ),
        ),
      ),
    );
  }
}
