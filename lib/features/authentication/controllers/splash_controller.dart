import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koin/data/isar/isar_service.dart';
import 'package:koin/features/authentication/screens/onboarding/onboarding.dart';
import 'package:koin/features/authentication/screens/permissions/location_permission.dart';
import 'package:koin/features/authentication/screens/permissions/notification_permission.dart';
import 'package:koin/features/authentication/screens/personal_info/personal_info.dart';
import 'package:koin/features/authentication/screens/permissions/sms_permission.dart';
import 'package:koin/features/authentication/screens/sms_data/sms_data.dart';
import 'package:koin/navigation_menu.dart';

class SplashController extends GetxController {
  static SplashController get instance => Get.find();

  @override
  void onReady() {
    super.onReady();
    // FlutterNativeSplash.remove();
    checkAndNavigate();
  }

  Future<void> checkAndNavigate() async {
    final settings = await IsarService.instance.settings();

    if (!settings.onboardingCompleted) {
      Get.offAll(() => const OnBoardingScreen());
    } else if (!settings.personalInfoCompleted) {
      Get.offAll(() => const PersonaInfoScreen());
    } else if (!settings.smsContactGranted) {
      Get.offAll(() => const SmsPermissionScreen());
    } else if (!settings.notificationGranted) {
      Get.offAll(() => const NotificationPermissionScreen());
    } else if (!settings.locationGranted) {
      Get.offAll(() => const LocationPermissionScreen());
    } else if (!settings.smsProcessingCompleted) {
      Get.offAll(() => const SmsDataScreen());
    } else {
      Get.offAll(() => const NavigationMenu());
    }
  }
}
