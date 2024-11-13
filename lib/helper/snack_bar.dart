import 'package:finance_tracker/styles/colors.dart';
import 'package:flutter/material.dart';

class SnackBarHelper {
  static SnackBar createSnackBar({required String text}) {
    return SnackBar(
      content: Text(text),
      backgroundColor: AppColors.accentColor,
      duration: const Duration(seconds: 1),
    );
  }
}
