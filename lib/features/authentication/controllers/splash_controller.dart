import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:koin/data/isar/isar_service.dart';
import 'package:koin/features/authentication/screens/onboarding/onboarding.dart';
import 'package:koin/features/authentication/screens/permissions/location_permission.dart';
import 'package:koin/features/authentication/screens/permissions/notification_permission.dart';
import 'package:koin/features/authentication/screens/personal_info/personal_info.dart';
import 'package:koin/features/authentication/screens/permissions/sms_permission.dart';
import 'package:koin/features/authentication/screens/sms_data/sms_data.dart';
import 'package:koin/features/koin/controllers/transaction_cotroller.dart';
import 'package:koin/navigation_menu.dart';
import 'package:koin/utils/services/sms_listener.dart';

class SplashController extends GetxController {
  static SplashController get instance => Get.find();

  @override
  void onReady() {
    super.onReady();
    _initialize();
  }

  Future<void> _initialize() async {
    FlutterNativeSplash.remove();

    // Small delay to ensure Isar is ready
    await Future.delayed(Duration(milliseconds: 100));

    await _checkAndNavigate();
  }

  Future<void> _checkAndNavigate() async {
    try {
      final settings = await IsarService.instance.settings();

      // Initialize SMS listener if processing is complete
      if (settings.smsProcessingCompleted && !SmsListenerService.isListening) {
        await SmsListenerService.initialize();
      }

      // Navigate based on completion status
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
    } catch (e) {
      print('Error in splash navigation: $e');
      Get.offAll(() => const OnBoardingScreen()); // Fallback
    }
  }
}
