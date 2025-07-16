import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:koin/common/widgets/icons/circular_icon.dart';
import 'package:koin/features/authentication/controllers/personal_info_controller.dart';
import 'package:koin/utils/constants/colors.dart';
import 'package:koin/utils/constants/sizes.dart';
import 'package:koin/utils/device/device_utility.dart';
import 'package:koin/utils/helpers/helper_functions.dart';
import 'package:koin/utils/validators/validation.dart';

class PersonaInfoScreen extends StatelessWidget {
  const PersonaInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PersonaInfoController());
    final isDark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: TSizes.defaultSpace * 1.25,
              vertical: TSizes.defaultSpace * 2,
            ),
            child: Column(
              children: [
                SizedBox(height: TSizes.spaceBtwSections),

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
                    ).textTheme.headlineLarge!.copyWith(fontSize: 80),
                    textAlign: TextAlign.start,
                  ),
                ),
                Text(
                  "Know your money",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: TSizes.spaceBtwSections * 2),
                Row(
                  children: [
                    Obx(() {
                      final image = controller.profileImage.value;
                      return GestureDetector(
                        onTap: controller.pickImage,
                        child: KProfileImage(image: image),
                      );
                    }),
                    SizedBox(width: 15),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "login to ",
                              style: Theme.of(
                                context,
                              ).textTheme.titleSmall!.copyWith(fontSize: 22),
                            ),
                            TextSpan(
                              text: 'supercharge your finance',
                              style: Theme.of(context).textTheme.titleSmall!
                                  .copyWith(
                                    fontSize: 22,
                                    color: TColors.primary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                //Email
                SizedBox(height: TSizes.spaceBtwSections),
                TextFormField(
                  controller: controller.username,
                  validator: (value) =>
                      TValidator.validateEmptyText("Name", value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user_edit),
                    labelText: "Name",
                  ),
                ),
                SizedBox(height: TSizes.spaceBtwInputFields),

                TextFormField(
                  controller: controller.phoneNumber,
                  validator: (value) => TValidator.validatePhoneNumber(value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.call),
                    labelText: "Phone Number",
                  ),
                ),

                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.submit,
                    child: const Text("Get Started"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    "New account will be created for a new number.",
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class KProfileImage extends StatelessWidget {
  const KProfileImage({super.key, required this.image});

  final File? image;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: Radius.circular(10),
        dashPattern: [10, 5],
        strokeWidth: 2,
        color: THelperFunctions.getThemeModeColor(isDark, 0.25),
      ),
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: image != null
            ? Image.asset(image!.path, fit: BoxFit.cover)
            : Center(
                child: Container(
                  height: 40,
                  width: 45,
                  // color: Colors.red,
                  child: Stack(
                    children: [
                      Icon(
                        Iconsax.gallery,
                        size: 30,
                        color: THelperFunctions.getThemeModeColor(isDark, 0.75),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: KCircularIcon(
                          icon: Iconsax.add,
                          backgroundColor: TColors.primary,
                          iconColor: Colors.white,
                          size: 25,
                          iconSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
