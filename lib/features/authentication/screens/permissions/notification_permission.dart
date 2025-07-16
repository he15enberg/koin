import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:koin/common/chips/simple_icon_text_chip.dart';
import 'package:koin/common/widgets/images/oonboading_image.dart';
import 'package:koin/features/authentication/controllers/permissions_controller.dart.dart';
import 'package:koin/features/authentication/screens/permissions/location_permission.dart';
import 'package:koin/features/authentication/screens/permissions/widgets/permission_page.dart';
import 'package:koin/utils/constants/colors.dart';
import 'package:koin/utils/constants/image_strings.dart';

class NotificationPermissionScreen extends StatelessWidget {
  const NotificationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final permissionController = PermissionsController.instance;

    return Scaffold(
      body: KPermissionPage(
        icon: Iconsax.notification,
        title: "Notification Permission",
        description:
            "Enable alerts to get bill reminders, budget insights & real-time updates",
        chips: const [
          KSimpleIconTextChip(
            icon: Iconsax.notification_status,
            text: "No spam",
          ),
          KSimpleIconTextChip(
            icon: Iconsax.timer_1,
            text: "Only timely alerts",
          ),
        ],
        image: const KOnboadingImage(image: TImages.onBoardingImage4),
        highlightMessage: "Smart Notifications",
        onTap: () => permissionController.requestNotificationPermission(),

        buttonText: "Grant Notification permission",
      ),
    );
  }
}
