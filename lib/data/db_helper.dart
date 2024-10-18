import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'constants.dart';

class DbHelper {
  //1) - create single instance
  DbHelper._(); //private named constructor
  static final DbHelper helper = DbHelper._(); //single instance

  //2- get db path
  Future<String> _getDbPath() async {
    String path = await getDatabasesPath();
    return join(path, Constant.dbName);
  }

  //3- create or open db
  Future<Database> getDbInstance() async {
    String dbPath = await _getDbPath();
    return openDatabase(dbPath,
        version: Constant.dbVersion,
        onCreate: (db, version) => _onCreate(db),
        onUpgrade: (db, oldVersion, newVersion) => _onUpgrade(db),
        onDowngrade: (db, oldVersion, newVersion) => _onDowngrade(db),
        onOpen: (db) => print('On Open'),
        onConfigure: (db) => print('On Configure'),
        singleInstance: true);
  }

  void _onCreate(Database db) {
    try {
      db.execute(Constant.createNoteTableSql);
    } on DatabaseException catch (e) {
      print(e.toString());
    }
  }

  void _onUpgrade(Database db) {
    try {
      db.execute(Constant.upgradeNoteTableSql);
      _onCreate(db);
    } on DatabaseException catch (e) {
      print(e.toString());
    }
  }

  void _onDowngrade(Database db) {
    // _onCreate(db);
  }
}
