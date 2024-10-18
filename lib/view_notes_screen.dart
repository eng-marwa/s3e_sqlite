import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:s3e_sqlite/core/color_manager.dart';
import 'package:s3e_sqlite/core/image_manager.dart';
import 'package:s3e_sqlite/home.dart';
import 'package:s3e_sqlite/model/note.dart';
import 'package:s3e_sqlite/utils/context_extension.dart';
import 'package:s3e_sqlite/utils/date_time_manager.dart';

import 'core/text_styles.dart';
import 'data/crud.dart';
import 'widgets/note_input_widget.dart';

class ViewNotesScreen extends StatefulWidget {
  const ViewNotesScreen({super.key});

  @override
  State<ViewNotesScreen> createState() => _ViewNotesScreenState();
}

class _ViewNotesScreenState extends State<ViewNotesScreen> {
  List<Note> _list = [];
  late TextEditingController _titleController;
  late TextEditingController _textController;
  final GlobalKey<FormState> _editKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _viewNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      appBar: AppBar(
        title: Text(
          'Notes',
          style: TextStyles.title,
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: Row(
                children: [
                  SvgPicture.asset(ImageManager.searchIcon),
                  SizedBox(
                    width: 8.w,
                  ),
                  SvgPicture.asset(ImageManager.infoIcon),
                ],
              ))
        ],
        backgroundColor: ColorManager.primaryColor,
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          child: Visibility(
            visible: _list.isNotEmpty,
            replacement:
                Center(child: SvgPicture.asset(ImageManager.emptyNotes)),
            child: ListView.builder(
                itemCount: _list.length,
                itemBuilder: (context, index) => Dismissible(
                    onDismissed: (direction) {
                      if (direction == DismissDirection.startToEnd) {
                        _deleteNote(_list[index].noteId!);
                      } else {
                        print('Edit');
                        _showUpdateDialog(_list[index]);
                      }
                    },
                    background: Container(
                        margin: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: ColorManager.redColor,
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.delete,
                          color: ColorManager.whiteColor,
                        )),
                    secondaryBackground: Container(
                        margin: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: ColorManager.greenColor,
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.edit,
                          color: ColorManager.whiteColor,
                        )),
                    key: UniqueKey(),
                    child: Container(
                      padding: EdgeInsets.all(16.r),
                      margin: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Color(_list[index].noteColor!)),
                      child: ListTile(
                        title: Text(
                          _list[index].noteTitle,
                          style: TextStyles.noteTitle,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _list[index].noteText,
                              style: TextStyles.noteText,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                DateTimeManager.toTimeAgo(
                                    _list[index].createdAt),
                                style: TextStyles.noteDate,
                              ),
                            )
                          ],
                        ),
                      ),
                    ))),
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManager.blackColor,
        shape: const CircleBorder(),
        onPressed: () async {
          // Navigate to the next screen and await result
          bool? result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MyHomePage(),
            ),
          );

          // If result is true, refresh the list
          if (result == true) {
            _viewNotes(); // Reload the notes from the database
          }
        },
        child: const Icon(
          Icons.add,
          color: ColorManager.whiteColor,
        ),
      ),
    );
  }

  void _viewNotes() {
    Crud.crud.select().then(
      (noteList) {
        setState(() {
          _list = noteList;
        });
      },
    );
  }

  void _deleteNote(int noteId) {
    Crud.crud.delete(noteId).then(
      (row) {
        print('$row');
        if (row > 0) {
          context.showSnackBar('Note deleted successfully');
          _viewNotes();
        }
      },
    );
  }

  void _showUpdateDialog(Note note) {
    _titleController = TextEditingController(text: note.noteTitle);
    _textController = TextEditingController(text: note.noteText);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorManager.primaryColor,
        title: Text('Update Notw'),
        content: Form(
            key: _editKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                NoteInput(
                  controller: _titleController,
                  label: 'Title',
                  textStyles: TextStyles.noteTitleLabel,
                ),
                NoteInput(
                  controller: _textController,
                  label: 'Note Text',
                  textStyles: TextStyles.noteTextLabel,
                )
              ],
            )),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          TextButton(
              onPressed: () {
                if (_editKey.currentState!.validate()) {
                  note.noteText = _textController.value.text;
                  note.noteTitle = _titleController.value.text;
                  _updateNote(note);
                  Navigator.pop(context);
                }
              },
              child: Text('Update')),
        ],
      ),
    );
  }

  void _updateNote(Note note) {
    Crud.crud.update(note).then(
      (row) {
        context.showSnackBar('Note Updated');
        _viewNotes();
      },
    );
  }
}
