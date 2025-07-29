import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:koin/common/widgets/chips/simple_icon_text_chip.dart';
import 'package:koin/common/widgets/images/oonboading_image.dart';
import 'package:koin/features/authentication/controllers/permissions_controller.dart.dart';
import 'package:koin/features/authentication/screens/permissions/widgets/permission_page.dart';
import 'package:koin/utils/constants/colors.dart';
import 'package:koin/utils/constants/image_strings.dart';

class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final permissionController = PermissionsController.instance;

    return Scaffold(
      body: KPermissionPage(
        icon: Iconsax.location,
        title: "Location Permission",
        description:
            "To accurately categorise your spends based on the location of your transaction",
        chips: const [
          KSimpleIconTextChip(icon: Iconsax.map_1, text: "No tracking"),
          KSimpleIconTextChip(icon: Iconsax.shield_tick, text: "Only insights"),
        ],
        image: const KOnboadingImage(image: TImages.onBoardingImage5),
        highlightMessage: "Location-based Insights",
        onTap: () => permissionController.requestLocationPermission(),
        buttonText: "Grant Location permission",
      ),
    );
  }
}
