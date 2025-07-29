import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:koin/common/widgets/chips/simple_icon_text_chip.dart';
import 'package:koin/common/widgets/images/oonboading_image.dart';
import 'package:koin/features/authentication/controllers/permissions_controller.dart.dart';
import 'package:koin/features/authentication/screens/permissions/location_permission.dart';
import 'package:koin/features/authentication/screens/permissions/notification_permission.dart';
import 'package:koin/features/authentication/screens/permissions/widgets/permission_page.dart';
import 'package:koin/utils/constants/colors.dart';
import 'package:koin/utils/constants/image_strings.dart';

class SmsPermissionScreen extends StatelessWidget {
  const SmsPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final permissionController = Get.put(PermissionsController());
    return Scaffold(
      body: KPermissionPage(
        icon: Iconsax.sms_tracking,
        title: "SMS Permission",
        description:
            "This helps us process your transactional SMS into your spends & bill reminders",
        chips: const [
          KSimpleIconTextChip(icon: Iconsax.password_check, text: "No OTP"),
          KSimpleIconTextChip(icon: Iconsax.user_tag, text: "No personal SMS"),
        ],
        image: const KOnboadingImage(image: TImages.onBoardingImage6),
        highlightMessage: "Backup and Restore",
        onTap: () => permissionController.requestSmsAndContactPermissions(),
        buttonText: "Grant SMS permission",
      ),
    );
  }
}
