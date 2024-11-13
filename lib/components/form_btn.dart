import 'package:finance_tracker/styles/colors.dart';
import 'package:flutter/material.dart';

class FormButtonSubmit extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const FormButtonSubmit({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentColor,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(color: AppColors.buttonTextColor),
        ),
      ),
    );
  }
}
