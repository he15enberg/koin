import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:koin/data/isar/models/transaction_model.dart';
import 'package:path_provider/path_provider.dart';
import 'models/settings_model.dart';

class IsarService extends GetxService {
  static IsarService get instance => Get.find<IsarService>();

  late Isar _isar;
  final settings = SettingsModel().obs;

  Future<IsarService> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([
      SettingsModelSchema,
      TransactionModelSchema,
    ], directory: dir.path);

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

  Future<void> saveTransactions(List<TransactionModel> transactions) async {
    await _isar.writeTxn(() async {
      await _isar.transactionModels.putAll(transactions);
    });
  }

  Future<void> setSmsProcessingCompleted() async {
    settings.value.smsProcessingCompleted = true;
    await save();
  }

  Future<List<TransactionModel>> getAllTransactions() async {
    return await _isar.transactionModels.where().findAll();
  }

  Future<List<TransactionModel>> getCurrentMonthTransactions() async {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0, 23, 59, 59);

    return await _isar.transactionModels
        .filter()
        .dateTimeGreaterThan(startOfMonth)
        .and()
        .dateTimeLessThan(endOfMonth)
        .findAll();
  }
}
