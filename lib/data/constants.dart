class Constant {
  Constant._();

  static const String dbName = 'notes.db';
  static const int dbVersion = 2;
  static const String tableName = 'note';
  static const String colId = 'note_id';
  static const String colTitle = 'note_title';
  static const String colText = 'note_text';
  static const String colDate = 'createdAt';
  static const String colUpdatedDate = 'updatedAt';
  static const String colColor = 'note_color';

  static String createNoteTableSql =
      'Create table $tableName ( $colId integer primary key autoincrement, $colTitle text, $colText text, $colDate text, $colUpdatedDate text, $colColor integer ) ';

  static String upgradeNoteTableSql = 'drop table if exists $tableName';
}
