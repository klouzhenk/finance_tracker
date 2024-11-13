import 'package:finance_tracker/styles/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: AppColors.primaryColor,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
