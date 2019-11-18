import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database(String tablename) async {
    final dbPath = await sql.getDatabasesPath();
    final tablePath = path.join(dbPath, '$tablename.db');
    return sql.openDatabase(tablePath,
        onCreate: (sql.Database db, int version) =>
            _onCreate(db, version, tablename),
        version: 1);
  }

  static Future<void> insert(String tablename, Map<String, Object> data) async {
    final sqlDb = await database(tablename);

    await sqlDb.insert('user_$tablename', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, Object>>> getData(String tablename) async {
    final sqlDb = await database(tablename);
    return sqlDb.query('user_$tablename');
  }

  static _onCreate(sql.Database db, int _version, String tablename) {
    var executeQuery =
        'CREATE TABLE user_$tablename(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)';
    return db.execute(executeQuery);
  }
}
