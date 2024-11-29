import 'package:flutter/material.dart';

class AlertDialogTitle extends StatelessWidget {
  const AlertDialogTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color.fromARGB(200, 255, 255, 255),
        fontSize: 28,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
      ),
    );
  }
}
