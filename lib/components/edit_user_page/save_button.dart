import 'package:finance_tracker/helper/color.dart';
import 'package:flutter/material.dart';

class AlertDialogSaveButton extends StatelessWidget {
  const AlertDialogSaveButton(this.onSave, {super.key});

  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onSave,
      child: const Text(
        'Save',
        style: TextStyle(
          color: AppColors.accentColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
