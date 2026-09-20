import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/// Owns the single sqflite [Database] connection and the schema. Repositories
/// (SettingsRepository, TransactionRepository) depend on this for a
/// connection but never touch SQL outside their own table.
class AppDatabase extends GetxService {
  static AppDatabase get instance => Get.find();

  static const _dbName = 'koin.db';
  static const _dbVersion = 1;

  late final Database database;

  Future<AppDatabase> init() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, _dbName);
    database = await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
    return this;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE settings (
        id INTEGER PRIMARY KEY CHECK (id = 0),
        onboarding_completed INTEGER NOT NULL DEFAULT 0,
        personal_info_completed INTEGER NOT NULL DEFAULT 0,
        sms_contact_granted INTEGER NOT NULL DEFAULT 0,
        notification_granted INTEGER NOT NULL DEFAULT 0,
        location_granted INTEGER NOT NULL DEFAULT 0,
        sms_processing_completed INTEGER NOT NULL DEFAULT 0,
        username TEXT,
        phone_number TEXT,
        profile_image_path TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        bank_code TEXT NOT NULL,
        amount REAL NOT NULL,
        bank_name TEXT NOT NULL,
        bank_photo TEXT NOT NULL,
        account_last_four_digits TEXT NOT NULL,
        merchant_name TEXT NOT NULL,
        date_time INTEGER NOT NULL,
        reference_number TEXT NOT NULL,
        sms_type TEXT NOT NULL,
        message_address TEXT NOT NULL,
        message_body TEXT NOT NULL,
        merchant_photo TEXT,
        category TEXT,
        dedup_key TEXT UNIQUE
      )
    ''');

    await db.execute(
      'CREATE INDEX idx_transactions_date_time ON transactions(date_time)',
    );
  }
}
