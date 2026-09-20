import 'package:get/get.dart';
import 'package:koin/data/local/app_database.dart';
import 'package:koin/data/local/models/settings_model.dart';

/// Single-row app settings (onboarding/permission flags + user profile).
/// Holds the current row reactively so controllers can keep reading
/// `settings.value` / mutating it via `settings.update(...)` exactly as
/// they did against the old IsarService.
class SettingsRepository extends GetxService {
  static SettingsRepository get instance => Get.find();

  final AppDatabase _db = Get.find<AppDatabase>();
  final settings = SettingsModel().obs;

  Future<SettingsRepository> init() async {
    final rows = await _db.database.query(
      'settings',
      where: 'id = ?',
      whereArgs: [0],
    );

    if (rows.isEmpty) {
      final newSettings = SettingsModel(id: 0);
      await _db.database.insert('settings', newSettings.toMap());
      settings.value = newSettings;
    } else {
      settings.value = SettingsModel.fromMap(rows.first);
    }

    return this;
  }

  Future<void> save() async {
    await _db.database.update(
      'settings',
      settings.value.toMap(),
      where: 'id = ?',
      whereArgs: [0],
    );
  }

  Future<void> setSmsProcessingCompleted() async {
    settings.value.smsProcessingCompleted = true;
    await save();
  }
}
