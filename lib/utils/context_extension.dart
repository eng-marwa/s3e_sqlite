import 'dart:async';

import 'package:flutter/material.dart';
import 'package:s3e_sqlite/core/color_manager.dart';

extension ContextExtension on BuildContext {
  void showBanner(String message) {
    var messengerState = ScaffoldMessenger.of(this);
    Timer(
      const Duration(seconds: 3),
      () {
        messengerState.hideCurrentMaterialBanner();
      },
    );
    messengerState.showMaterialBanner(
        MaterialBanner(content: Text(message), actions: const [Text('')]));
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: ColorManager.primaryColor,
    ));
  }
}
