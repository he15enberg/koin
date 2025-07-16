import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:koin/data/isar/isar_service.dart';
import 'package:koin/features/authentication/screens/permissions/sms_permission.dart';

class PersonaInfoController extends GetxController {
  static PersonaInfoController get instance => Get.find();

  final username = TextEditingController();
  final phoneNumber = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Rx<File?> profileImage = Rx<File?>(null);

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
    }
  }

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      final service = IsarService.instance;

      // Update Isar settings model
      service.settings.update((val) {
        val?.username = username.text;
        val?.phoneNumber = phoneNumber.text;
        val?.profileImagePath = profileImage.value?.path;
        val?.personalInfoCompleted = true;
      });

      await service.save();

      // Go to permissions screen
      Get.offAll(() => const SmsPermissionScreen());
    }
  }

  @override
  void onClose() {
    username.dispose();
    phoneNumber.dispose();
    super.onClose();
  }
}
