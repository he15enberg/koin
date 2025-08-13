import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koin/common/widgets/shimmers/shimmer_effect.dart';
import 'package:koin/features/koin/controllers/profile_controller.dart';
import 'package:koin/utils/constants/colors.dart';
import 'package:koin/utils/constants/image_strings.dart';
import 'package:koin/utils/helpers/helper_functions.dart';

class KProfileBox extends StatelessWidget {
  const KProfileBox({super.key, required this.profileController});

  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark ? TColors.darkestGrey : TColors.darkGrey,
        ),
      ),
      child: Obx(
        () => profileController.isLoading.value
            ? Row(
                children: [
                  KShimmerEffect(width: 50, height: 50, radius: 100),
                  SizedBox(width: 7.5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KShimmerEffect(width: 150),
                      SizedBox(height: 2.5),
                      KShimmerEffect(width: 100),
                    ],
                  ),
                ],
              )
            : Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: profileController.profileImage.value != null
                        ? Image.file(
                            profileController.profileImage.value!,
                            fit: BoxFit.cover,
                            height: 50,
                            width: 50,
                          )
                        : Image.asset(
                            TImages.user,
                            fit: BoxFit.cover,
                            height: 50,
                            width: 50,
                          ),
                  ),
                  SizedBox(width: 7.5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profileController.username.value,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 2.5),

                        Text(
                          "+91 ${profileController.phoneNumber.value}",
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                color: THelperFunctions.getThemeModeColor(
                                  opacity: 0.5,
                                ),
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
