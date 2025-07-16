import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class KSimpleIconTextChip extends StatelessWidget {
  const KSimpleIconTextChip({
    super.key,
    required this.icon,
    required this.text,
  });
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(children: [Icon(icon), SizedBox(width: 7.5), Text(text)]);
  }
}
