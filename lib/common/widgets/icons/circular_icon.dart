import 'package:flutter/material.dart';
import 'package:koin/utils/constants/colors.dart';

class KCircularIcon extends StatelessWidget {
  const KCircularIcon({
    super.key,
    required this.icon,
    this.size = 45,
    this.iconSize = 25,
    this.backgroundColor = TColors.accent,
    this.iconColor = TColors.primary,
  });
  final IconData icon;
  final double size;
  final double iconSize;
  final Color backgroundColor;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: backgroundColor),
      child: Icon(icon, size: iconSize, color: iconColor),
    );
  }
}
