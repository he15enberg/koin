import 'package:isar/isar.dart';

part 'settings_model.g.dart';

@collection
class SettingsModel {
  Id id = 0;

  // Flags
  bool onboardingCompleted = false;

  bool personalInfoCompleted = false;

  bool smsContactGranted = false;
  bool notificationGranted = false;
  bool locationGranted = false;

  bool smsProcessingCompleted = false;

  // User Info
  String? username;
  String? phoneNumber;
  String? profileImagePath;
}
