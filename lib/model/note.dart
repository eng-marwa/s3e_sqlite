import 'package:s3e_sqlite/data/constants.dart';

class Note {
  int? noteId;
  String noteTitle;
  String noteText;
  String createdAt;

  Note(
      {this.noteId,
      required this.noteTitle,
      required this.noteText,
      required this.createdAt});

  //convert note object to map
  Map<String, dynamic> toMap() => {
        Constant.colId: noteId,
        Constant.colTitle: noteTitle,
        Constant.colText: noteText,
        Constant.colDate: createdAt
      };
}
