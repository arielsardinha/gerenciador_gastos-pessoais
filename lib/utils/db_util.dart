import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbUtil {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'conta.db'),
      onCreate: (db, version) {
        _createDb(db);
      },
      version: 1,
    );
  }

  static void _createDb(sql.Database db) {
    db.execute(""" 
    CREATE TABLE conta (id INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo VARCHAR(50), saldo REAL)
    """);
  }

  static Future<void> insertData(
      String table, Map<String, dynamic> data) async {
    final db = await database();
    await db.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }
}
