import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:koin/utils/constants/colors.dart';
import 'package:koin/utils/helpers/helper_functions.dart';

class KUtilityIconButton extends StatelessWidget {
  const KUtilityIconButton({super.key, required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 7.5, vertical: 7.5),
          decoration: BoxDecoration(
            color: TColors.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            spacing: 5,
            children: [
              Icon(icon, color: Colors.white, size: 17.5),
              Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
