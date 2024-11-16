import 'package:finance_tracker/pages/expenses.dart';
import 'package:finance_tracker/pages/login.dart';
import 'package:finance_tracker/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
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
        textTheme:
            GoogleFonts.latoTextTheme(Theme.of(context).textTheme).copyWith(
          headlineLarge: const TextStyle(
            color: AppColors.accentColor,
            fontSize: 40,
            fontWeight: FontWeight.w900,
          ),
          labelLarge: const TextStyle(
            color: AppColors.accentColor,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: const TextStyle(color: AppColors.textColor, fontSize: 18),
          bodyLarge: const TextStyle(color: AppColors.textColor, fontSize: 18),
        ),
      ),
      home: const LoginPage(),
    );
  }
}
