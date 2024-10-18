import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:s3e_sqlite/core/color_manager.dart';
import 'package:s3e_sqlite/core/text_styles.dart';
import 'package:s3e_sqlite/model/note.dart';
import 'package:s3e_sqlite/utils/context_extension.dart';
import 'package:s3e_sqlite/utils/date_time_manager.dart';
import 'package:s3e_sqlite/view_notes_screen.dart';
import 'package:s3e_sqlite/widgets/new_note_app_bar.dart';
import 'package:s3e_sqlite/widgets/note_input_widget.dart';
import 'data/crud.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _key = GlobalKey();
  late TextEditingController _titleController;
  late TextEditingController _textController;
  int _colorIndex = 2;

  @override
  void initState() {
    _titleController = TextEditingController();
    _textController = TextEditingController();
    // _titleController.addListener(
    //   () {
    //     print(_titleController.value.text);
    //   },
    // );
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewNoteAppBar(child: Text('Note'), callback: () => _addNewNote()),
      backgroundColor: ColorManager.primaryColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Form(
                key: _key,
                child: Padding(
                  padding: EdgeInsets.all(8.0.r),
                  child: Column(
                    children: [
                      NoteInput(
                        controller: _titleController,
                        label: 'Title',
                        maxLines: 1,
                        textStyles: TextStyles.noteTitleLabel,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      NoteInput(
                        textStyles: TextStyles.noteTextLabel,
                        controller: _textController,
                        label: 'Type something...',
                      )
                    ],
                  ),
                )),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: EdgeInsets.all(8.0.r),
              child: SizedBox(
                height: 60.h,
                width: double.infinity,
                child: Row(
                  children: ColorManager.notesColors
                      .map((e) => GestureDetector(
                            onTap: () {
                              setState(() {
                                _colorIndex =
                                    ColorManager.notesColors.indexOf(e);
                              });
                              print(_colorIndex);
                            },
                            child: Container(
                              width: 60.w,
                              height: 60,
                              color: e,
                              child: Visibility(
                                  child: Icon(Icons.check),
                                  visible: _colorIndex ==
                                      ColorManager.notesColors.indexOf(e)),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      )),
    );
  }

  void _saveNote(Note note) {
    Crud.crud.insert(note).then(
      (rowId) {
        if (rowId > 0) {
          //clear fields
          _titleController.clear();
          _textController.clear();
          context.showSnackBar('Data inserted');
          //notify user
          //update ui
        }
      },
    );
  }

  void _addNewNote() {
    if (_key.currentState!.validate()) {
      _saveNote(
        Note(
            noteColor: ColorManager.notesColors[_colorIndex].value,
            noteTitle: _titleController.value.text,
            noteText: _textController.value.text,
            createdAt: DateTimeManager.getCurrentDateTime()),
      );
    }
  }
}
/*
TextFormField(
                        validator: (value) =>
                            value!.isEmpty ? 'This field is required' : null,
                        controller: _textController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _secure,
                        obscuringCharacter: '*',
                        decoration: InputDecoration(
                            hintText: 'Text',
                            suffixIcon: IconButton(
                              icon: Visibility(
                                child: Icon(Icons.visibility),
                                replacement: Icon(Icons.visibility_off),
                                visible: _secure,
                              ),
                              onPressed: () {
                                setState(() {
                                  _secure = !_secure;
                                });
                              },
                            )),
                      )
 */
