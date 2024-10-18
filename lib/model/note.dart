import 'package:s3e_sqlite/data/constants.dart';

class Note {
  int? noteId;
  String noteTitle;
  String noteText;
  String createdAt;
  String? updatedAt;
  int? noteColor;

  Note(
      {this.noteId,
      required this.noteTitle,
      required this.noteText,
      required this.createdAt,
      this.updatedAt,
      this.noteColor});

  //convert note object to map
  Map<String, dynamic> toMap() => {
        Constant.colId: noteId,
        Constant.colTitle: noteTitle,
        Constant.colText: noteText,
        Constant.colDate: createdAt,
        Constant.colUpdatedDate: updatedAt,
        Constant.colColor: noteColor
      };

  //convert map to note object
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
        noteId: map[Constant.colId],
        noteTitle: map[Constant.colTitle],
        noteText: map[Constant.colText],
        createdAt: map[Constant.colDate],
        updatedAt: map[Constant.colUpdatedDate],
        noteColor: map[Constant.colColor]);
  }
}
