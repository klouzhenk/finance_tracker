import 'package:finance_tracker/styles/colors.dart';
import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile(this.text, this.icon, this.onTap, {super.key});

  final String text;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.accentColor),
      title: Text(text),
      onTap: onTap,
    );
  }
}
