import 'package:get/get.dart';
import 'package:koin/data/isar/isar_service.dart';
import 'package:koin/features/authentication/controllers/splash_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(IsarService(), permanent: true);
    Get.put(SplashController(), permanent: true);
  }
}
