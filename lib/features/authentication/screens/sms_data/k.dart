import 'package:flutter/material.dart';
import 'package:koin/common/widgets/images/oonboading_image.dart';
import 'package:koin/utils/constants/colors.dart';
import 'package:koin/utils/constants/image_strings.dart';
import 'package:koin/utils/constants/sizes.dart';

class SmsDataScreen extends StatelessWidget {
  const SmsDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: TSizes.defaultSpace * 1.25,
            vertical: TSizes.defaultSpace * 2,
          ),
          child: Column(
            children: [
              ShaderMask(
                shaderCallback: (bounds) {
                  return LinearGradient(
                    colors: [TColors.primary, TColors.accent],
                  ).createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  );
                },
                blendMode: BlendMode.srcIn,
                child: Text(
                  "koin",
                  style: Theme.of(
                    context,
                  ).textTheme.headlineLarge!.copyWith(fontSize: 60),
                  textAlign: TextAlign.start,
                ),
              ),
              Text(
                "Know your money",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              KOnboadingImage(image: TImages.onBoardingImage2),
            ],
          ),
        ),
      ),
    );
  }
}
