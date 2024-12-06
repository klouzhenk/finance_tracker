import 'package:finance_tracker/helper/color.dart';
import 'package:flutter/material.dart';

class AlertDialogTextField extends StatelessWidget {
  const AlertDialogTextField(this.controller, this.labelText,
      {super.key, this.obscureText = false});

  final TextEditingController controller;
  final String labelText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: AppColors.buttonTextColor),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Color.fromARGB(160, 255, 255, 255)),
        enabledBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(160, 255, 255, 255), width: 0.0),
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
