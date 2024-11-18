import 'package:flutter/material.dart';

class AppIconBtn extends StatelessWidget {
  const AppIconBtn(this.icon, this.size, this.color,
      {super.key, required this.onPressed});

  final IconData icon;
  final double size;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      iconSize: size,
      color: color,
      onPressed: onPressed,
    );
  }
}
