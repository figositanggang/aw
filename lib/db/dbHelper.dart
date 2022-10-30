import 'package:database_/model/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Database? _database;
  final String _tableName = "note";
  final String _dbName = "note_database.db";
  final int _dbVersion = 1;

  DBHelper() {
    _initializeDB();
  }

  Future<void> _initializeDB() async {
    var path = join(await getDatabasesPath(), _dbName);

    _database = await openDatabase(
      path,
      onCreate: ((db, version) {
        return db.execute(
            "CREATE TABLE $_tableName (id INTEGER PRIMARY KEY, note TEXT)");
      }),
      version: _dbVersion,
    );
  }

  // READ
  Future<List<Note>> getNote() async {
    if (this._database != null) {
      final List<Map<String, dynamic>> maps =
          await this._database!.query(_tableName);

      return List.generate(
        maps.length,
        (index) {
          var data = maps[index];

          return Note(data['id'], data['note']);
        },
      );
    }

    return [];
  }

  // INSERT
  Future<void> insertNote(Note note) async {
    await this._database?.insert(
          _tableName,
          note.toMap(),
        );
  }

  // CLOSE DB
  Future<void> closeDB() async {
    await this._database?.close();
  }
}
