import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:s3e_sqlite/core/color_manager.dart';
import 'package:s3e_sqlite/view_notes_screen.dart';

class TextStyles {
  TextStyles._();

  static TextStyle get title => TextStyle(
      fontSize: 34.sp,
      fontFamily: 'Nunito',
      color: ColorManager.whiteColor,
      fontWeight: FontWeight.w600);

  static TextStyle get noteText => TextStyle(
      fontSize: 22.sp,
      fontFamily: 'Nunito',
      color: ColorManager.blackColor,
      fontWeight: FontWeight.normal);

  static TextStyle get noteTitle => TextStyle(
      fontSize: 25.sp,
      fontFamily: 'Nunito',
      color: ColorManager.blackColor,
      fontWeight: FontWeight.bold);

  static TextStyle get noteDate => TextStyle(
      fontSize: 14.sp,
      fontFamily: 'Nunito',
      color: ColorManager.blackColor,
      fontWeight: FontWeight.normal);

  static TextStyle get noteTitleLabel => TextStyle(
      fontSize: 34.sp,
      fontFamily: 'Nunito',
      color: ColorManager.greyColor,
      fontWeight: FontWeight.normal);

  static TextStyle get noteTextLabel => TextStyle(
      fontSize: 16.sp,
      fontFamily: 'Nunito',
      color: ColorManager.greyColor,
      fontWeight: FontWeight.normal);
}
