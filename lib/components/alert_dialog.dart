import 'package:finance_tracker/styles/colors.dart';
import 'package:flutter/material.dart';

class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog(this.title, this.content, {super.key});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          color: Color.fromARGB(200, 255, 255, 255),
          fontSize: 28,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
      content: Text(
        content,
        style: const TextStyle(
          color: Color.fromARGB(200, 255, 255, 255),
        ),
      ),
      backgroundColor: AppColors.accentColor,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: AppColors.buttonTextColor),
          ),
        ),
      ],
    );
  }
}
