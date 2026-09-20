import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();
  static ValueNotifier<double> valueNotifier = ValueNotifier(0);
}
