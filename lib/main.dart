import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:koin/data/local/app_database.dart';
import 'package:koin/data/local/repositories/settings_repository.dart';
import 'package:koin/data/local/repositories/transaction_repository.dart';
import 'package:koin/features/onboarding/controllers/splash_controller.dart';
import 'package:koin/features/transactions/controllers/transaction_controller.dart';
import 'package:koin/services/sms_engine/sms_listener_service.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent
      statusBarIconBrightness:
          Brightness.dark, // Icons color for light background
    ),
  );

  try {
    // Database + repositories, in dependency order
    if (!Get.isRegistered<AppDatabase>()) {
      await Get.putAsync(() => AppDatabase().init(), permanent: true);
    }
    if (!Get.isRegistered<SettingsRepository>()) {
      await Get.putAsync(() => SettingsRepository().init(), permanent: true);
    }
    if (!Get.isRegistered<TransactionRepository>()) {
      Get.put(TransactionRepository(), permanent: true);
    }

    // Initialize controllers only once
    if (!Get.isRegistered<TransactionController>()) {
      Get.put(TransactionController(), permanent: true);
    }
    if (!Get.isRegistered<SplashController>()) {
      Get.put(SplashController(), permanent: true);
    }

    print('App initialization completed');
  } catch (e) {
    print('Error during app initialization: $e');
  }

  runApp(const App());
}
