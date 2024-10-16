import 'package:flutter/material.dart';
import 'package:s3e_sqlite/model/note.dart';
import 'package:s3e_sqlite/utils/context_extension.dart';
import 'package:s3e_sqlite/utils/date_time_manager.dart';
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
  bool _secure = true;

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
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'Note App',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
            ),
            const SizedBox(
              height: 8,
            ),
            Form(
                key: _key,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      NoteInput(
                        controller: _titleController,
                        label: 'Note Title',
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      NoteInput(controller: _textController, label: 'Note Text')
                    ],
                  ),
                )),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    _saveNote(Note(
                        noteTitle: _titleController.value.text,
                        noteText: _textController.value.text,
                        createdAt: DateTimeManager.getCurrentDateTime()));
                  }
                },
                child: Text('Add Note'))
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
          context.showBanner('Data inserted');
          //notify user
          //update ui
        }
      },
    );
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
