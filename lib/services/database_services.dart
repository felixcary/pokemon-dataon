import 'package:pokemon/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static const String usersTable = 'users';

  Future<Database> open() async {
    final databasePath = await getDatabasesPath();
    final database = await openDatabase(
      '$databasePath/pokemon_app.db',
      onCreate: _createTables,
      onUpgrade: (db, oldVersion, newVersion) async {
        var batch = db.batch();

        await batch.commit();
      },
      version: 1,
    );

    return database;
  }

  Future<void> _createTables(Database db, int version) async {
    var batch = db.batch();
    _createTableUsers(batch);
    await batch.commit();
  }

  void _createTableUsers(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS $usersTable');
    batch.execute('''
      CREATE TABLE $usersTable (
        id INTEGER PRIMARY KEY,
        email TEXT,
        password TEXT
      )
    ''');
  }

  Future<void> insertUser(UserModel user) async {
    final db = await open();
    await db.insert('users', user.toMap());
    await db.close();
  }

  Future<UserModel?> getUserByEmail(String email) async {
    final db = await open();
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isEmpty) {
      return null;
    }

    return UserModel.fromMap(maps.first);
  }
}
