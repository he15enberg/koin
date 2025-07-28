import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:koin/common/widgets/button/simple_circular_icon_button.dart';
import 'package:koin/common/widgets/shimmers/shimmer_effect.dart';
import 'package:koin/features/koin/controllers/profile_controller.dart';
import 'package:koin/utils/constants/colors.dart';
import 'package:koin/utils/constants/image_strings.dart';
import 'package:koin/utils/constants/sizes.dart';
import 'package:koin/utils/helpers/helper_functions.dart';

class KScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KScreenAppBar({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Container(
      height: preferredSize.height,
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        spacing: 10,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: KSimpleCircularIconButton(
              icon: Iconsax.arrow_left,
              iconsize: 20,
              padding: 5,
              iconColor: isDark ? TColors.white : TColors.black,
              backgroundColor: isDark ? TColors.darkerGrey : TColors.grey,
            ),
          ),
          Text(text, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
