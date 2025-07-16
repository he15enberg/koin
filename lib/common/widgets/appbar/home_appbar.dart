import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:koin/utils/constants/image_strings.dart';
import 'package:koin/utils/constants/sizes.dart';

class KHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
      decoration: const BoxDecoration(),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(TImages.user, height: 35, width: 35),
          ),
          SizedBox(width: 15),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Hi ',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                TextSpan(
                  text: 'Heisenberg',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Spacer(),
          const Icon(Iconsax.search_normal_1, color: Colors.white),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
