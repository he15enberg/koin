import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:koin/common/widgets/appbar/screen_appbar.dart';
import 'package:koin/common/widgets/button/simple_circular_icon_button.dart';
import 'package:koin/common/widgets/transaction/section.dart';
import 'package:koin/common/widgets/transaction/transaction_box.dart';
import 'package:koin/data/local/models/transaction_model.dart';
import 'package:koin/features/transactions/controllers/transaction_controller.dart';
import 'package:koin/utils/constants/colors.dart';
import 'package:koin/services/sms_engine/bank_directory.dart';
import 'package:koin/utils/helpers/formatters.dart';
import 'package:koin/utils/helpers/helper_functions.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key, required this.transaction});
  final TransactionModel transaction;
  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final transactionController = TransactionController.instance;
    return Scaffold(
      // backgroundColor: Color.alphaBlend(
      //   Colors.white.withOpacity(0.95), // amount of white to mix in
      //   KFormatters.getCategoryInfo(transaction.category)["color"],
      // ),
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
              //Transaction Box Widget
              KTransactionBox(
                date: KFormatters.formatDateTimeToLongString(
                  transaction.dateTime,
                ),
                merchantName: transaction.merchantName,
                visitsText: "62 visits",
                smsType: transaction.smsType,
                amount: KFormatters.formatToRupees(transaction.amount),
                category: transaction.category,
                isDark: isDark,
              ),

              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: TColors.accent.withAlpha((255 * 0.5).toInt()),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 5,
                      children: [
                        Builder(
                          builder: (context) {
                            // getBankInfo can return null for a sender code
                            // that isn't in the directory yet (e.g. a bank
                            // format we haven't added) -- fall back to a
                            // generic icon instead of crashing on `!`.
                            final bankInfo = BankDirectory.getBankInfo(
                              transaction.bankCode,
                            );
                            return bankInfo != null
                                ? Image.asset(
                                    height: 30,
                                    width: 30,
                                    fit: BoxFit.cover,
                                    bankInfo.image,
                                  )
                                : const Icon(Iconsax.bank, size: 30);
                          },
                        ),
                        Text(
                          transaction.bankCode,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          transaction.accountLastFourDigits,
                          style: Theme.of(context).textTheme.bodyLarge!,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Expense",
                          style: Theme.of(context).textTheme.bodySmall!,
                        ),
                        Obx(
                          () => Transform.scale(
                            scale: 0.75,
                            child: Switch(
                              value: transactionController
                                  .isTransactionExpense
                                  .value,
                              onChanged: (value) =>
                                  transactionController
                                          .isTransactionExpense
                                          .value =
                                      value,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              KTransactionSection(
                icon: Iconsax.note_1,
                title: "Notes",
                child: Padding(
                  padding: const EdgeInsets.only(top: 7.5),
                  child: TextField(),
                ),
              ),
              KTransactionSection(
                icon: Iconsax.tag,
                title: "Tags",
                action: Icon(Iconsax.add),
              ),
              KTransactionSection(
                icon: Iconsax.firstline,
                title: "Other Info",
                child: Padding(
                  padding: const EdgeInsets.only(top: 7.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Location",
                        style: Theme.of(context).textTheme.labelMedium!,
                      ),
                      Text("See Map"),
                      Divider(),
                      Text(
                        "Ref No",
                        style: Theme.of(context).textTheme.labelMedium!,
                      ),
                      Text(transaction.referenceNumber ?? "Unknown"),
                      Divider(),

                      Text(
                        "SMS",
                        style: Theme.of(context).textTheme.labelMedium!,
                      ),
                      Text(
                        "[${transaction.messageAddress}]\n${transaction.messageBody}" ??
                            "Unknown",
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
