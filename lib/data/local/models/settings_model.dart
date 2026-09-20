class SettingsModel {
  int id;

  // Flags
  bool onboardingCompleted;
  bool personalInfoCompleted;

  bool smsContactGranted;
  bool notificationGranted;
  bool locationGranted;

  bool smsProcessingCompleted;

  // User Info
  String? username;
  String? phoneNumber;
  String? profileImagePath;

  SettingsModel({
    this.id = 0,
    this.onboardingCompleted = false,
    this.personalInfoCompleted = false,
    this.smsContactGranted = false,
    this.notificationGranted = false,
    this.locationGranted = false,
    this.smsProcessingCompleted = false,
    this.username,
    this.phoneNumber,
    this.profileImagePath,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'onboarding_completed': onboardingCompleted ? 1 : 0,
      'personal_info_completed': personalInfoCompleted ? 1 : 0,
      'sms_contact_granted': smsContactGranted ? 1 : 0,
      'notification_granted': notificationGranted ? 1 : 0,
      'location_granted': locationGranted ? 1 : 0,
      'sms_processing_completed': smsProcessingCompleted ? 1 : 0,
      'username': username,
      'phone_number': phoneNumber,
      'profile_image_path': profileImagePath,
    };
  }

  factory SettingsModel.fromMap(Map<String, Object?> map) {
    return SettingsModel(
      id: map['id'] as int,
      onboardingCompleted: (map['onboarding_completed'] as int) == 1,
      personalInfoCompleted: (map['personal_info_completed'] as int) == 1,
      smsContactGranted: (map['sms_contact_granted'] as int) == 1,
      notificationGranted: (map['notification_granted'] as int) == 1,
      locationGranted: (map['location_granted'] as int) == 1,
      smsProcessingCompleted: (map['sms_processing_completed'] as int) == 1,
      username: map['username'] as String?,
      phoneNumber: map['phone_number'] as String?,
      profileImagePath: map['profile_image_path'] as String?,
    );
  }
}
