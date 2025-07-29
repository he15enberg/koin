import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:koin/common/widgets/chips/simple_icon_text_chip.dart';
import 'package:koin/common/widgets/icons/circular_icon.dart';
import 'package:koin/common/widgets/images/oonboading_image.dart';
import 'package:koin/utils/constants/colors.dart';
import 'package:koin/utils/constants/image_strings.dart';
import 'package:koin/utils/constants/sizes.dart';

class KPermissionPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final List<Widget> chips;
  final Widget image;
  final String highlightMessage;
  final VoidCallback onTap;
  final String buttonText;

  const KPermissionPage({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.chips,
    required this.image,
    required this.highlightMessage,
    required this.onTap,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: TSizes.defaultSpace * 2,
        horizontal: TSizes.defaultSpace * 1.25,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              KCircularIcon(icon: icon),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.5),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Text(
                description,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: chips,
                ),
              ),
            ],
          ),
          image,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 17.5,
                width: 17.5,
                decoration: BoxDecoration(
                  color: TColors.success.withAlpha((0.25 * 255).toInt()),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Icon(Icons.check, size: 12.5, color: TColors.success),
              ),
              const SizedBox(width: 5),
              Text(
                highlightMessage,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: TColors.success.withAlpha((0.6 * 255).toInt()),
                ),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: onTap, child: Text(buttonText)),
          ),
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: [
                TextSpan(
                  text: "By giving us permission you agree to ",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                TextSpan(
                  text: "koin's terms of use",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: TColors.success.withAlpha((0.6 * 255).toInt()),
                  ),
                ),
                TextSpan(
                  text: " and ",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                TextSpan(
                  text: "privacy policy",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: TColors.success.withAlpha((0.6 * 255).toInt()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
