import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:koin/common/widgets/button/section_expand_button.dart';
import 'package:koin/common/widgets/button/simple_circular_icon_button.dart';
import 'package:koin/utils/constants/colors.dart';
import 'package:koin/utils/helpers/formatters.dart';
import 'package:koin/utils/helpers/helper_functions.dart';

class KDuesAndReminders extends StatelessWidget {
  const KDuesAndReminders({super.key});

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
                  "Dues & Reminders",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: THelperFunctions.getThemeModeColor(),
                  ),
                ),
                Icon(Icons.add),
              ],
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  width: 250, // Fixed width for each item
                  margin: EdgeInsets.only(left: 15, right: index == 4 ? 15 : 0),
                  decoration: BoxDecoration(
                    color: isDark ? TColors.dark : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isDark ? TColors.darkerGrey : TColors.grey,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 7.5,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(9),
                          ),
                          color: THelperFunctions.getPrimaryWithOpecity(
                            opacity: 0.2,
                          ),
                        ),
                        child: Row(
                          spacing: 5,
                          children: [
                            KSimpleCircularIconButton(
                              iconsize: 17.5,
                              icon: Iconsax.refresh_circle,
                              backgroundColor: TColors.primary,
                              iconColor: Colors.white,
                            ),
                            Text(
                              "Repeats Monthly",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              "31 Aug 25",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            spacing: 5,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Manjula S",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      KFormatters.formatToRupees(25000),
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Set reminder?",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelMedium,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min, // Key fix
                                    children: [
                                      Text(
                                        "Yes",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(color: TColors.primary),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "No",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(color: TColors.primary),
                                      ),
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
                );
              },
            ),
          ),
          const SizedBox(height: 7.5),

          KSectionExpandButton(),
          const SizedBox(height: 7.5),
        ],
      ),
    );
  }
}
