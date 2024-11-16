import 'package:finance_tracker/models/expense.dart';
import 'package:finance_tracker/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    print(_database);
    if (_database != null) return _database!;
    _database = await _initDB('app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE expense (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        title TEXT NOT NULL,
        description TEXT,
        amount REAL NOT NULL,
        category TEXT,
        date TEXT NOT NULL,
        FOREIGN KEY (user_id) REFERENCES user (id) ON DELETE CASCADE
      )
    ''');
  }

  Future<void> insertUser(String username, String password) async {
    final db = await instance.database;
    await db.insert(
      'user',
      {'username': username, 'password': password},
    );
  }

  Future<int> insertExpense(int userId, String title, String description,
      double amount, String category, String date) async {
    final db = await instance.database;
    return await db.insert(
      'expense',
      {
        'user_id': userId,
        'title': title,
        'description': description,
        'amount': amount,
        'category': category,
        'date': date,
      },
    );
  }

  Future<List<Expense>> getUserExpenses(int userId) async {
    final db = await instance.database;
    final result = await db.query(
      'expense',
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    if (result.isNotEmpty) {
      return result.map((e) => Expense.fromMap(e)).toList();
    }

    return [];
  }

  Future<void> deleteUser(int userId) async {
    final db = await instance.database;
    await db.delete(
      'user',
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  Future<bool> checkUser(String username, String password) async {
    final db = await instance.database;
    final result = await db.query(
      'user',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    return result.isNotEmpty;
  }

  Future<User?> getUser(String username, String password) async {
    final db = await instance.database;
    final result = await db.query(
      'user',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }

  Future<bool> checkUserExisting(String username) async {
    final db = await instance.database;
    final result = await db.query(
      'user',
      where: 'username = ?',
      whereArgs: [username],
    );
    return result.isNotEmpty;
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
