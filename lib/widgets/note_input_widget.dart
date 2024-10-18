import 'package:flutter/material.dart';
import 'package:s3e_sqlite/core/text_styles.dart';

class NoteInput extends StatelessWidget {
  int maxLines;
  final TextEditingController controller;
  final String label;
  final TextStyle textStyles;

  NoteInput(
      {this.maxLines = 10,
      required this.controller,
      required this.label,
      required this.textStyles,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 1,
      style: textStyles,
      maxLines: maxLines,
      validator: (value) => value!.isEmpty ? 'This field is required' : null,
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: textStyles,
      ),
    );
  }
}
