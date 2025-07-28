import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:koin/common/widgets/shimmers/shimmer_effect.dart';
import 'package:koin/features/koin/controllers/profile_controller.dart';
import 'package:koin/utils/constants/image_strings.dart';
import 'package:koin/utils/constants/sizes.dart';
import 'package:koin/utils/helpers/helper_functions.dart';

class KHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    return Container(
      height: preferredSize.height,
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
      child: Obx(
        () => profileController.isLoading.value
            ? Row(
                children: [
                  KShimmerEffect(width: 35, height: 35, radius: 100),
                  SizedBox(width: 15),
                  KShimmerEffect(width: 100),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: profileController.profileImage.value != null
                            ? Image.file(
                                profileController.profileImage.value!,
                                fit: BoxFit.cover,
                                height: 35,
                                width: 35,
                              )
                            : Image.asset(
                                TImages.user,
                                fit: BoxFit.cover,
                                height: 35,
                                width: 35,
                              ),
                      ),
                      const SizedBox(width: 15),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Hi ',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            TextSpan(
                              text: profileController.username.value,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Icon(
                    Icons.search,
                    color: THelperFunctions.getThemeModeColor(),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
