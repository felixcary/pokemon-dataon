import 'package:pokemon/models/pokemon_detail_model.dart';
import 'package:pokemon/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static const String usersTable = 'users';
  static const String pokemonFavoriteTable = 'pokemonFavorite';

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
    _createTablePokemonFavorite(batch);
    await batch.commit();
  }

  void _createTableUsers(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS $usersTable');
    batch.execute('''
      CREATE TABLE $usersTable (
        id INTEGER PRIMARY KEY,
        name TEXT,
        email TEXT,
        password TEXT,
        avatar TEXT
      )
    ''');
  }

  void _createTablePokemonFavorite(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS $pokemonFavoriteTable');
    batch.execute('''
      CREATE TABLE $pokemonFavoriteTable (
        id INTEGER PRIMARY KEY,
        name TEXT,
        url TEXT
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

  Future<void> updateProfile({
    required String newName,
    required String avatar,
    required int id,
  }) async {
    final db = await open();
    await db.update(
      usersTable,
      {'name': newName, 'avatar': avatar},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> addPokemonToFavorite(PokemonSpecies pokemonSpecies) async {
    final db = await open();

    await db.insert(
      pokemonFavoriteTable,
      pokemonSpecies.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await db.close();
  }

  Future<void> removePokemonFromFavorite(String name) async {
    final db = await open();
    await db.delete(pokemonFavoriteTable, where: 'name = ?', whereArgs: [name]);
    await db.close();
  }

  Future<bool> getPokemonFavoriteStatus(String name) async {
    final db = await open();
    final pokemonData = await db
        .query(pokemonFavoriteTable, where: 'name = ?', whereArgs: [name]);
    return pokemonData.isNotEmpty;
  }

  Future<List<PokemonSpecies>> getAllPokemonFavorite() async {
    final db = await open();

    final pokemonFavoriteMap = await db.query(pokemonFavoriteTable);
    var pokemonFavorite = pokemonFavoriteMap
        .map((result) => PokemonSpecies.fromMap(result))
        .toList();
    return pokemonFavorite;
  }
}
