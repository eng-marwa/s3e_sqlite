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

//update

//delete
}
