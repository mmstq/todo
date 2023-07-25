import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo/model/todo_model.dart';

class DatabaseHelper {
  static const _databaseName = "todo.db";
  static const _databaseVersion = 2;
  static const table = "todo";
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnNote = 'note';
  static const columnDate = 'dueDate';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''  CREATE TABLE $table (    
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnTitle FLOAT NOT NULL,
        $columnNote FLOAT NOT NULL,
        $columnDate FLOAT NOT NULL  )  
        ''');
  }

  Future<int> insert(Todo todo) async {
    Database db = await instance.database;
    var res = await db.insert(table, todo.toMap());
    return res;
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    var res = await db.query(table, orderBy: "$columnId DESC");
    return res;
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List<Map<String, Object?>>> clearTable() async {
    Database db = await instance.database;
    return await db.rawQuery("DELETE FROM $table");
  }
}
