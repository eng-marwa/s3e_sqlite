import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:s3e_sqlite/core/image_manager.dart';

class NewNoteAppBar extends StatelessWidget implements PreferredSize {
  final Widget child;
  final VoidCallback? callback;

  const NewNoteAppBar({required this.child, this.callback, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 24.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              child: SvgPicture.asset(ImageManager.backIcon),
              onTap: () => Navigator.pop(context, true),
            ),
            GestureDetector(
              onTap: callback,
              child: SvgPicture.asset(ImageManager.saveIcon),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80.h);
}
