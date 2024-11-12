import 'package:flutter/material.dart';

class SnackBarHelper {
  static SnackBar createSnackBar({required String text}) {
    return SnackBar(
      content: Text(text),
      backgroundColor: const Color.fromARGB(255, 82, 125, 255),
    );
  }
}
