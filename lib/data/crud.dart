import 'package:s3e_sqlite/data/constants.dart';
import 'package:s3e_sqlite/data/db_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../model/note.dart';

class Crud {
  //1-single instance
  Crud._();

  static final Crud crud = Crud._();

  //insert
  Future<int> insert(Note note) async {
    Database db = await DbHelper.helper.getDbInstance();
    return await db.insert(Constant.tableName, note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

//select
  Future<List<Note>> select() async {
    Database db = await DbHelper.helper.getDbInstance();
    List<Map<String, dynamic>> result = await db.query(Constant.tableName,
        distinct: true, orderBy: '${Constant.colDate} desc');
    return result.map((e) => Note.fromMap(e)).toList();
  }

//update
  Future<int> update(Note note) async {
    Database db = await DbHelper.helper.getDbInstance();
    return db.update(Constant.tableName, note.toMap(),
        where: '${Constant.colId}=?', whereArgs: [note.noteId!]);
  }

//delete
  Future<int> delete(int id) async {
    Database db = await DbHelper.helper.getDbInstance();
    return db.delete(Constant.tableName,
        where: '${Constant.colId}=?', whereArgs: [id]);
  }
}
