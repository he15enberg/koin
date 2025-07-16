import 'package:flutter/material.dart';
import 'package:koin/common/widgets/images/oonboading_image.dart';
import 'package:koin/utils/constants/colors.dart';
import 'package:koin/utils/constants/sizes.dart';
import 'package:koin/utils/helpers/helper_functions.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });
  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: THelperFunctions.screenHeight(),
      width: THelperFunctions.screenWidth(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          KOnboadingImage(image: image),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: TSizes.defaultSpace * 1.25,
              vertical: TSizes.spaceBtwInputFields,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                // ShaderMask(
                //   shaderCallback: (bounds) {
                //     return LinearGradient(
                //       colors: [TColors.primary, TColors.primary.withAlpha(150)],
                //     ).createShader(
                //       Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                //     );
                //   },
                //   blendMode: BlendMode.srcIn,
                //   child: Text(
                //     title,
                //     style: Theme.of(
                //       context,
                //     ).textTheme.headlineLarge!.copyWith(fontSize: 40),
                //     textAlign: TextAlign.start,
                //   ),
                // ),
                Text(
                  subTitle,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: TSizes.defaultSpace * 3),
        ],
      ),
    );
  }
}
