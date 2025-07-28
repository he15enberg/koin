import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koin/data/isar/isar_service.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();
  static ValueNotifier<double> valueNotifier = ValueNotifier(0);
}
