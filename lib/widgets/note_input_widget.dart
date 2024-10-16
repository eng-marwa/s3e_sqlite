import 'package:flutter/material.dart';

class NoteInput extends StatelessWidget {
  int maxLines;
  TextEditingController controller;
  String label;

  NoteInput(
      {this.maxLines = 10,
      required this.controller,
      required this.label,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 1,
      maxLines: maxLines,
      validator: (value) => value!.isEmpty ? 'This field is required' : null,
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.blue, width: 2)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.green, width: 2)),
        labelText: label,
      ),
    );
  }
}
