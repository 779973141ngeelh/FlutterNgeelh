import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
  static Database? _database;
  static final String userTable = 'user';
  static final String orderTable = 'order';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'app.db');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  void _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $userTable (
       ' id 'INTEGER PRIMARY KEY,
       ' username' TEXT,
       ' password' TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $orderTable (
        id INTEGER PRIMARY KEY,
        userId INTEGER,
        status TEXT,
        totalPrice REAL,
        date TEXT,
        orderDetails TEXT
      )
    ''');
  }

  Future<int> addUser(Map<String, dynamic> user) async {
    Database db = await database;
    return await db.insert(userTable, user);
  }

  Future<Map<String, dynamic>?> getUser(
      String username, String password) async {
    Database db = await database;
    List<Map<String, dynamic>> users = await db.query(userTable,
        where: 'username = ? AND password = ?',
        whereArgs: [username, password]);
    if (users.isNotEmpty) {
      return users.first;
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getOrders(int userId) async {
    Database db = await database;
    return await db.query(orderTable, where: 'userId = ?', whereArgs: [userId]);
  }
}
