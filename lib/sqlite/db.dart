import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlTest {
  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initilDb();
      return _db;
    } else {
      return _db;
    }
  }

  initilDb() async {
    String databasepath = await getDatabasesPath();

    String path = join(databasepath, "test.db");

    Database mydb = await openDatabase(path, version: 1, onCreate: _oncreate);

    return mydb;
  }

  _oncreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE "notes" ("id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,"note"	TEXT NOT NULL)');
    print("INSERT TABLE SUCCESS");
  }

  readData(String sql) async {
    Database mydb = await db;

    List<Map> response = await mydb.rawQuery(sql);

    return response;
  }

  insertData(String sql) async {
    Database mydb = await db;

    int response = await mydb.rawInsert(sql);

    return response;
  }

  updateData(String sql) async {
    Database mydb = await db;

    int response = await mydb.rawUpdate(sql);

    return response;
  }

  deleteData(String sql) async {
    Database mydb = await db;

    int response = await mydb.rawDelete(sql);

    return response;
  }

 
}
