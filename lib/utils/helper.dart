import 'package:flutter/material.dart';

class Helper {
  static void showMessage(final context, final message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
