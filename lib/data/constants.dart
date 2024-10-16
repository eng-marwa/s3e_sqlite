class Constant {
  Constant._();
  static const String dbName = 'notes.db';
  static const int dbVersion = 1;
  static const String tableName = 'note';
  static const String colId = 'note_id';
  static const String colTitle = 'note_title';
  static const String colText = 'note_text';
  static const String colDate = 'createdAt';

  static String createNoteTableSql =
      'Create table $tableName ( $colId integer primary key autoincrement, $colTitle text, $colText text, $colDate text ) ';

  static String upgradeNoteTableSql = '';
}
