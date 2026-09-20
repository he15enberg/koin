import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:koin/data/local/repositories/settings_repository.dart';
import 'package:koin/features/onboarding/screens/onboarding/onboarding.dart';
import 'package:koin/features/onboarding/screens/permissions/location_permission.dart';
import 'package:koin/features/onboarding/screens/permissions/notification_permission.dart';
import 'package:koin/features/onboarding/screens/personal_info/personal_info.dart';
import 'package:koin/features/onboarding/screens/permissions/sms_permission.dart';
import 'package:koin/features/onboarding/screens/sms_data/sms_data.dart';
import 'package:koin/features/transactions/controllers/transaction_controller.dart';
import 'package:koin/navigation_menu.dart';
import 'package:koin/services/sms_engine/sms_listener_service.dart';

class SplashController extends GetxController {
  static SplashController get instance => Get.find();

  @override
  void onReady() {
    super.onReady();
    _initialize();
  }

  Future<void> _initialize() async {
    FlutterNativeSplash.remove();

    // Small delay to ensure the database is ready
    await Future.delayed(Duration(milliseconds: 100));

    await _checkAndNavigate();
  }

  Future<void> _checkAndNavigate() async {
    try {
      final settings = SettingsRepository.instance.settings.value;

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
