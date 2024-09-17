import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../models/user/user_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('my_database.db');
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

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE users (
      uid TEXT PRIMARY KEY,
      name TEXT,
      email TEXT,
      password TEXT,
      fcmToken TEXT
    )
    ''');
  }

  Future<int> insertUser(UserModel user) async {
    final db = await instance.database;
    return await db.insert('users', user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
  Future<UserModel?> fetchUserById(String uid) async {
    final db = await instance.database;
    final maps = await db.query(
      'users',
      columns: [
        'uid',
        'name',
        'email',
        'password',
        'fcmToken',
      ],
      where: 'uid = ?',
      whereArgs: [uid],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<int> updateUser(UserModel user) async {
    final db = await instance.database;
    return await db.update(
      'users',
      user.toJson(),
      where: 'uid = ?',
      whereArgs: [user.uid],
    );
  }

  Future<void> deleteUser(String uid) async {
    final db = await instance.database;
    await db.delete(
      'users',
      where: 'uid = ?',
      whereArgs: [uid],
    );
  }
}
