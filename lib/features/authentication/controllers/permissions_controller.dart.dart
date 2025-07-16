import 'package:get/get.dart';
import 'package:koin/features/authentication/screens/sms_data/sms_data.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:koin/common/widgets/loaders.dart';
import 'package:koin/data/isar/isar_service.dart';
import 'package:koin/features/authentication/screens/permissions/notification_permission.dart';
import 'package:koin/features/authentication/screens/permissions/location_permission.dart';
import 'package:koin/navigation_menu.dart';

class PermissionsController extends GetxController {
  static PermissionsController get instance => Get.find();

  /// SMS + Contacts
  Future<void> requestSmsAndContactPermissions() async {
    final settings = IsarService.instance.settings.value;

    if (settings.smsContactGranted) {
      Get.to(() => const NotificationPermissionScreen());
      return;
    }

    final smsGranted = await _request(Permission.sms, "SMS");
    if (!smsGranted) return;

    final contactGranted = await _request(Permission.contacts, "Contacts");
    if (!contactGranted) return;

    IsarService.instance.settings.update((val) {
      val?.smsContactGranted = true;
    });
    await IsarService.instance.save();

    Get.to(() => const NotificationPermissionScreen());
  }

  /// Notification
  Future<void> requestNotificationPermission() async {
    final settings = IsarService.instance.settings.value;

    if (settings.notificationGranted) {
      Get.to(() => const LocationPermissionScreen());
      return;
    }

    final granted = await _request(Permission.notification, "Notification");
    if (!granted) return;

    IsarService.instance.settings.update((val) {
      val?.notificationGranted = true;
    });
    await IsarService.instance.save();

    Get.to(() => const LocationPermissionScreen());
  }

  /// Location
  Future<void> requestLocationPermission() async {
    final settings = IsarService.instance.settings.value;

    if (settings.locationGranted) {
      Get.offAll(() => const SmsDataScreen());
      return;
    }

    final granted = await _request(Permission.location, "Location");
    if (!granted) return;

    IsarService.instance.settings.update((val) {
      val?.locationGranted = true;
    });
    await IsarService.instance.save();

    Get.offAll(() => const SmsDataScreen());
  }

  /// Common permission requester
  Future<bool> _request(Permission permission, String label) async {
    final status = await permission.status;
    if (status.isGranted) return true;

    final result = await permission.request();
    if (!result.isGranted) {
      KLoaders.errorSnackBar(
        title: "Permission Denied",
        message: "$label permission is required to continue.",
      );
      return false;
    }

    return true;
  }
}
