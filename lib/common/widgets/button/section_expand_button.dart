import 'package:flutter/material.dart';
import 'package:koin/utils/helpers/helper_functions.dart';

class KSectionExpandButton extends StatelessWidget {
  const KSectionExpandButton({super.key, this.onTap});
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 25,
              color: THelperFunctions.getThemeModeColor(opacity: 0.75),
            ),
          ],
        ),
      ),
    );
  }
}
