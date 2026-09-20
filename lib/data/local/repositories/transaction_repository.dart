import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:koin/data/local/app_database.dart';
import 'package:koin/data/local/models/transaction_model.dart';

class TransactionRepository extends GetxService {
  static TransactionRepository get instance => Get.find();

  final AppDatabase _db = Get.find<AppDatabase>();

  /// ConflictAlgorithm.ignore + the UNIQUE dedup_key column means saving the
  /// same real SMS twice (foreground listener + background service both
  /// received it, or a rescan reprocesses it) is a silent no-op, not a
  /// duplicate transaction.
  Future<void> saveTransaction(TransactionModel transaction) async {
    await _db.database.insert(
      'transactions',
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> saveTransactions(List<TransactionModel> transactions) async {
    final batch = _db.database.batch();
    for (final transaction in transactions) {
      batch.insert(
        'transactions',
        transaction.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<TransactionModel>> getAllTransactions() async {
    final rows = await _db.database.query(
      'transactions',
      orderBy: 'date_time DESC',
    );
    return rows.map(TransactionModel.fromMap).toList();
  }

  Future<List<TransactionModel>> getCurrentMonthTransactions() async {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
    return getTransactionsByDateRange(startOfMonth, endOfMonth);
  }

  Future<List<TransactionModel>> getTransactionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final rows = await _db.database.query(
      'transactions',
      where: 'date_time > ? AND date_time < ?',
      whereArgs: [
        startDate.millisecondsSinceEpoch,
        endDate.millisecondsSinceEpoch,
      ],
      orderBy: 'date_time DESC',
    );
    return rows.map(TransactionModel.fromMap).toList();
  }
}
