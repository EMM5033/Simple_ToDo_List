import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:sqflite/sqflite.dart';


class ToDo{
  Database _db;

  Future<Database> get _getDB async{
    if(_db == null){
      _db = await _initDB();
    }
    return _db;
  }

  _initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,"ToDo.db");
    return openDatabase(path,version: 1,onCreate: (Database db,int version)async {
      await db.execute("CREATE TABLE todo(name TEXT,content TEXT,color INTEGER)");
    });
  }


  insertTODO(String name,String content,int color) async{
    Database db = await _getDB;
    db.rawInsert("INSERT INTO todo(name,content,color) VALUES('$name','$content',$color)");
  }

  deleteFromTODO(String name)async{
    Database db = await _getDB;
    db.rawDelete("DELETE FROM todo WHERE NAME='$name'");
  }

  getAllData() async {
    Database db = await _getDB;
    return db.rawQuery("SELECT * FROM todo");
  }
    
}