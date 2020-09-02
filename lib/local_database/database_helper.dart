import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import './models/expense.dart';


class DatabaseHelper {
  static final _databaseName = 'MyDatabase.db';
  static final _databaseVersion = 1;
  static final table = 'my_table';
  static final columnId = '_id';
  static final columnName = 'title';
  static final columnAmount = 'amount';
  static final columnDateIs = 'dateis';

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;

  Future<Database> get database async {
    // ignore: always_put_control_body_on_new_line
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // ignore: unnecessary_await_in_return
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnAmount DOUBLE NOT NULL,
            $columnDateIs TEXT NOT NULL
          )
          ''');
  }

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<Expense> insert(Expense expense) async {
    var dbClient = await instance.database;
    expense.id = await dbClient.insert(table, expense.toMap());
    return expense;
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List> getAllData() async {
    List<Expense> data = List();
    var dbClient = await instance.database;
    List<Map> maps = await dbClient.query(table,
        columns: [columnId, columnName, columnAmount, columnDateIs]);
    if (maps.isNotEmpty) {
      maps.forEach((f) {
        data.add(Expense.fromMap(f));
      });
    }
    return data;
  }
}
