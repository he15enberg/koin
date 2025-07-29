import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:koin/data/isar/isar_service.dart';
import 'package:koin/features/authentication/controllers/splash_controller.dart';
import 'package:koin/features/koin/controllers/transaction_cotroller.dart';
import 'package:koin/utils/services/sms_listener.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Single Isar initialization
    if (!Get.isRegistered<IsarService>()) {
      await Get.putAsync(() => IsarService().init(), permanent: true);
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
