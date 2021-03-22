import 'dart:async';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class Note {

  static Database _db;

  Future<Database> get db async {

    if(_db == null)
    {
      _db = await initialDB();

      return _db; 
    
    }else{

      return _db;

    }

  }

  initialDB() async{
    io.Directory docDirect = await getApplicationDocumentsDirectory();
    String path = join(docDirect.path,'testdb.db');
    var mydb = await openDatabase(path,version: 1,onCreate: _onCreate);
    return mydb;
  }

  _onCreate(Database db,int version) async{
    await db.execute('CREATE TABLE "notes" ("id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,"note"	TEXT NOT NULL)');
    print('Notes Table Created');
  }

  Future<int> create(Map<String,dynamic> data) async{

    var db_client = await db;

    var insert = db_client.insert('notes', data);

    return insert;

  }

  Future<List> getData() async{
    
    var db_client = await db;

    var notes = await db_client.query('notes',orderBy: 'id DESC',limit: 2);
    
    return notes; 
    
  }

  Future<int> deleteNote(int id) async{

    var db_client = await db;

    var deleted_note = await db_client.rawUpdate('DELETE FROM notes WHERE id="$id"');

    return deleted_note;
  }

  Future<int> updateNote(String note,int id) async{

    var db_client = await db;

    var updated_note = await db_client.rawUpdate('UPDATE notes SET note="$note" WHERE id="$id" ');

    return updated_note;
  }


  Future<List> getSingleRow(int id) async{
    
    var db_client = await db;

    var note = await db_client.query('notes',where: 'id = "$id"');
    
    return note; 
    
  }

}