
import 'package:flutter/cupertino.dart';
import 'package:personal_expense_tracker_app/models/expense_item.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import '../../res/app_constants/app_constants.dart';

class ExpenseDatabaseRepository {

  static final ExpenseDatabaseRepository instance = ExpenseDatabaseRepository._init();
  ExpenseDatabaseRepository._init();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('expense.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
                        create table ${AppConst.tableName} ( 
                        ${AppConst.id} integer primary key autoincrement, 
                        ${AppConst.title} text not null,
                        ${AppConst.desc} text not null,
                        ${AppConst.amount} text not null,
                        ${AppConst.dateTime} text not null)
                     ''');
  }

  Future<void> insert({required ExpenseItem expenseItem}) async{
    Database db = await instance.database;
    await db.insert(AppConst.tableName, expenseItem.toMap());
  }

  Future<void> delete(int id) async {
    try {
      final db = await instance.database;
      await db.delete(
        AppConst.tableName,
        where: '${AppConst.id} = ?',
        whereArgs: [id],
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> update(ExpenseItem expenseItem) async {
    try {
      final db = await instance.database;
      db.update(
        AppConst.tableName,
        expenseItem.toMap(),
        where: '${AppConst.id} = ?',
        whereArgs: [expenseItem.id],
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<ExpenseItem>> getAllExpenses() async {
    final db = await instance.database;

    final result = await db.query(AppConst.tableName);

    return result.map((json) => ExpenseItem.fromJson(json)).toList();
  }

  Future<dynamic> deleteAllExpenses() async {
    final db = await instance.database;
    return await db.rawDelete('Delete from ${AppConst.tableName}');
  }

}

