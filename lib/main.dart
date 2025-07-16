import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:koin/data/isar/isar_service.dart';
import 'package:koin/features/authentication/controllers/splash_controller.dart';
import 'app.dart';

Future<void> main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  //Init Local Storage
  await Get.putAsync(() => IsarService().init(), permanent: true);
  Get.put(SplashController(), permanent: true);
  //Init Payment Methods
  //Await Native Splash
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Init Hive

  runApp(const App());
}
