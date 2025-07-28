import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:koin/common/widgets/button/simple_circular_icon_button.dart';
import 'package:koin/features/koin/screens/home/widgets/all_banks.dart';
import 'package:koin/utils/constants/colors.dart';
import 'package:koin/utils/helpers/formatters.dart';
import 'package:koin/utils/helpers/helper_functions.dart';

class KAccounts extends StatelessWidget {
  const KAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Container(
      decoration: BoxDecoration(
        color: isDark ? TColors.dark : const Color.fromARGB(255, 250, 250, 250),
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
                  "Accounts",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: THelperFunctions.getThemeModeColor(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 125,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BankListScreen()),
                  ),
                  child: Container(
                    width: 275,
                    margin: EdgeInsets.only(
                      left: 15,
                      right: index == 4 ? 15 : 0,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color.fromARGB(255, 44, 44, 44)
                          : Colors.white,

                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Color(
                                      0xFFF6B1B4,
                                    ).withAlpha((0.75 * 255).toInt())
                                  : Color(0xFFF6B1B4),
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset("assets/logos/HDFC Bank.png"),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text(
                                      "HDFC",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                    ),
                                    Text(
                                      "xx5594",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelMedium,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,

                          child: Container(
                            padding: EdgeInsets.all(15),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  spacing: 5,
                                  children: [
                                    Text(
                                      KFormatters.formatToRupees(45689),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                    ),
                                    KSimpleCircularIconButton(
                                      icon: Icons.arrow_outward,
                                      backgroundColor: isDark
                                          ? TColors.darkerGrey
                                          : TColors.grey,
                                      iconColor:
                                          THelperFunctions.getThemeModeColor(),
                                      iconsize: 20,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "12:42 am . 30, Jun",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(fontSize: 11),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      spacing: 2.5,
                                      children: [
                                        Icon(Iconsax.wallet_3, size: 20),
                                        Text(KFormatters.formatToRupees(45689)),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
