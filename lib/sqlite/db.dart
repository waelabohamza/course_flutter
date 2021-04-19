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

    Database mydb = await openDatabase(path,
        version: 3, onCreate: _oncreate, onUpgrade: __onUpgade);

    return mydb;
  }

  __onUpgade(Database db, int oldversion, int newversion) async {
    // CallBack when version upgrade
    //  print("===============================") ;
    //  print("Upgrade new : $newversion") ;
    //  print("Upgrade old : $oldversion") ;
  }
  _oncreate(Database db, int version) async {
    // CallBack only  once
    
    // For ====================== MultiTables 
    Batch batch = db.batch();
    batch.execute('''
    CREATE TABLE  "notes" 
    ("id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,"note"	TEXT NOT NULL)''');
    batch.execute('''
    CREATE TABLE  IF NOT EXISTS "books" 
    ("id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,"book"	TEXT NOT NULL)
    ''');
    List<dynamic> res = await batch.commit();
    // ==================== For one Table
    // await db.execute(
    //     'CREATE TABLE "notes" ("id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,"note"	TEXT NOT NULL)');
    print("INSERT TABLE SUCCESS $res");
  }

  readData(String table) async {
    Database mydb = await db;
    List<Map> response = await mydb.query(table);
    return response;
  }
    readDataWithFilter(String table, String wheredata, List listvalue) async {
    Database mydb = await db;
    List<Map> response =  await mydb.query(table, where: wheredata, whereArgs: listvalue);
    return response;
  }

  rawReadData(String sql) async {
    Database mydb = await db;

    List<Map> response = await mydb.rawQuery(sql);

    return response;
  }

  insertData(String table, Map data) async {
    Database mydb = await db;

    int response = await mydb.insert(table, data);

    return response;
  }

  rawInsertData(String sql) async {
    Database mydb = await db;

    int response = await mydb.rawInsert(sql);

    return response;
  }

  updateData(String table, Map data, String wheredata, List listvalue) async {
    Database mydb = await db;

    int response =
        await mydb.update(table, data, where: wheredata, whereArgs: listvalue);

    return response;
  }

  rawUpdateData(String sql) async {
    Database mydb = await db;

    int response = await mydb.rawUpdate(sql);

    return response;
  }

  deleteData(String table, String wheredata, List listvalue) async {
    Database mydb = await db;

    int response =
        await mydb.delete(table, where: wheredata, whereArgs: listvalue);

    return response;
  }

  rawDeleteData(String sql) async {
    Database mydb = await db;

    int response = await mydb.rawDelete(sql);

    return response;
  }

  myDeleteDatabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, "test.db");
    await deleteDatabase(path);
  }
}
