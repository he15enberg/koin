import 'dart:io';
import 'package:get/get.dart';
import 'package:koin/data/isar/isar_service.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final RxString username = ''.obs;
  final RxString phoneNumber = ''.obs;
  final Rx<File?> profileImage = Rx<File?>(null);
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final settings = IsarService.instance.settings.value;

    username.value = settings.username ?? '';
    phoneNumber.value = settings.phoneNumber ?? '';

    if (settings.profileImagePath != null) {
      final imageFile = File(settings.profileImagePath!);
      if (await imageFile.exists()) {
        profileImage.value = imageFile;
      }
    }

    isLoading.value = false;
  }
}
