import 'package:finance_tracker/pages/login.dart';
import 'package:finance_tracker/styles/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
          surface: AppColors.backgroundColor,
          primary: AppColors.primaryColor,
          onPrimary: AppColors.buttonTextColor,
        ),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: AppColors.textColor),
          labelLarge: TextStyle(
            color: AppColors.accentColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}
