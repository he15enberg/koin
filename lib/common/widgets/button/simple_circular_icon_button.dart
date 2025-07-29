import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:koin/utils/constants/colors.dart';
import 'package:koin/utils/helpers/helper_functions.dart';

class KSimpleCircularIconButton extends StatelessWidget {
  const KSimpleCircularIconButton({
    super.key,
    this.padding = 3,
    this.icon = Iconsax.arrow_right_4,
    this.iconsize,
    this.backgroundColor,
    this.iconColor,
  });
  final double padding;
  final IconData icon;
  final double? iconsize;
  final Color? backgroundColor;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color:
            backgroundColor ??
            (isDark ? const Color.fromARGB(255, 36, 36, 36) : TColors.grey),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: iconsize,
        color: iconColor ?? (isDark ? TColors.white : TColors.dark),
      ),
    );
  }
}
