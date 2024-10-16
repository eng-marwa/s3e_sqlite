import 'dart:async';

import 'package:flutter/material.dart';

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
}
