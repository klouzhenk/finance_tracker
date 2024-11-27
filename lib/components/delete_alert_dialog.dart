import 'package:finance_tracker/styles/colors.dart';
import 'package:flutter/material.dart';

class AlertDialogForDelete extends StatelessWidget {
  const AlertDialogForDelete(this.passwordController, {super.key});

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Confirm delete',
        style: TextStyle(
          color: Color.fromARGB(200, 255, 255, 255),
          fontSize: 28,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Input your password to confirm deleting',
            style: TextStyle(color: Color.fromARGB(200, 255, 255, 255)),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: passwordController,
            obscureText: true,
            style: const TextStyle(color: AppColors.buttonTextColor),
            decoration: const InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(color: Color.fromARGB(160, 255, 255, 255)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(160, 255, 255, 255), width: 0.0),
              ),
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.accentColor,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text(
            'Cancel',
            style: TextStyle(color: AppColors.buttonTextColor),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (passwordController.text.isNotEmpty) {
              Navigator.pop(context, true);
            }
          },
          child: const Text(
            'Delete',
            style: TextStyle(
              color: AppColors.darkAccentColor,
              letterSpacing: 1,
            ),
          ),
        ),
      ],
    );
  }
}
