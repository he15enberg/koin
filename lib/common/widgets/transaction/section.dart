import 'package:flutter/material.dart';
import 'package:koin/utils/constants/colors.dart';
import 'package:koin/utils/helpers/helper_functions.dart';

class KTransactionSection extends StatelessWidget {
  const KTransactionSection({
    super.key,
    required this.icon,
    required this.title,
    this.child,
    this.action,
  });
  final IconData icon;
  final String title;
  final Widget? child;
  final Widget? action;
  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: isDark ? TColors.dark : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: TColors.darkGrey, size: 20),
              SizedBox(width: 7.5),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  // fontWeight: FontWeight.bold,
                  color: TColors.darkGrey,
                ),
              ),
              Spacer(),
              action ?? Container(),
            ],
          ),
          child ?? Container(),
        ],
      ),
    );
  }
}
