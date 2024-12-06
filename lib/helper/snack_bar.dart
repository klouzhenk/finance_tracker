import 'package:finance_tracker/helper/color.dart';
import 'package:flutter/material.dart';

enum SnackBarType { success, warning, error }

class SnackBarHelper {
  static SnackBar createSnackBar(
      {required String text, required SnackBarType snackBarType}) {
    return SnackBar(
      content: Text(text),
      backgroundColor: _getSnackBarBackColor(snackBarType),
      duration: const Duration(seconds: 1),
    );
  }

  static void showSnackBar(
    BuildContext context,
    String text, {
    SnackBarType snackBarType = SnackBarType.error,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBarHelper.createSnackBar(text: text, snackBarType: snackBarType),
    );
  }

  static Color _getSnackBarBackColor(SnackBarType msgType) {
    switch (msgType) {
      case SnackBarType.success:
        return AppColors.primaryColor;
      case SnackBarType.error:
        return Colors.red;
      case SnackBarType.warning:
        return Colors.orange;
      default:
        return AppColors.accentColor;
    }
  }
}
