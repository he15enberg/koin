import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:koin/utils/constants/colors.dart';
import 'package:koin/utils/helpers/helper_functions.dart';

class KIconButton extends StatelessWidget {
  const KIconButton({super.key, required this.icon, required this.text});
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
            color: TColors.primary.withAlpha((0.1 * 255).toInt()),

            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: TColors.primary.withAlpha((0.5 * 255).toInt()),
            ),
          ),
          child: Row(
            spacing: 5,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white
                      : TColors.primary.withAlpha((0.25 * 255).toInt()),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: TColors.primary, size: 17.5),
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: THelperFunctions.getThemeModeColor(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
