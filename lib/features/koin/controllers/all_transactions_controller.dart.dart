import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koin/data/isar/isar_service.dart';
import 'package:koin/data/isar/models/transaction_model.dart';

class AllTransactionsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static AllTransactionsController get instance => Get.find();

  final tabs = ['Transactions', 'Categories', 'Merchants'];
  final RxBool isGraphOpen = false.obs;

  late AnimationController animationController;
  late Animation<double> sizeAnimation;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    sizeAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void toggleGraph() {
    isGraphOpen.value = !isGraphOpen.value;
    if (isGraphOpen.value) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    isGraphOpen.value = false;
    super.onClose();
  }
}
