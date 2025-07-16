import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:koin/data/isar/isar_service.dart'; // Ensure correct import
import 'package:koin/features/authentication/screens/personal_info/personal_info.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  void updatePageIndicator(int index) {
    currentPageIndex.value = index;
  }

  void dotNavigationClick(int index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  Future<void> nextPage() async {
    if (currentPageIndex.value == 2) {
      IsarService.instance.settings.update((val) {
        val?.onboardingCompleted = true;
      });

      await IsarService.instance.save();
      print(IsarService.instance.settings.value.onboardingCompleted);
      Get.offAll(() => const PersonaInfoScreen());
    } else {
      int next = currentPageIndex.value + 1;
      pageController.jumpToPage(next);
    }
  }

  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}
