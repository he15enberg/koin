import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:koin/utils/constants/colors.dart';

class KSimpleCircularIconButton extends StatelessWidget {
  const KSimpleCircularIconButton({
    super.key,
    this.padding = 3,
    this.icon = Iconsax.arrow_right_4,
    this.iconsize,
    this.backgroundColor = TColors.grey,
    this.iconColor = Colors.black,
  });
  final double padding;
  final IconData icon;
  final double? iconsize;
  final Color backgroundColor;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: Icon(icon, size: iconsize, color: iconColor),
    );
  }
}
