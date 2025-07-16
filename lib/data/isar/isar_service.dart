import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'models/settings_model.dart';

class IsarService extends GetxService {
  static IsarService get instance => Get.find<IsarService>();

  late Isar _isar;
  final settings = SettingsModel().obs;

  Future<IsarService> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([SettingsModelSchema], directory: dir.path);

    final existing = await _isar.settingsModels.get(0);
    if (existing == null) {
      final newSettings = SettingsModel()..id = 0;
      await _isar.writeTxn(() => _isar.settingsModels.put(newSettings));
      settings.value = newSettings;
    } else {
      settings.value = existing;
    }

    return this;
  }

  Future<SettingsModel> settingsModel() async {
    return await _isar.settingsModels.get(0) ?? SettingsModel();
  }

  Future<void> save() async {
    await _isar.writeTxn(() async {
      await _isar.settingsModels.put(settings.value);
    });
  }
}
