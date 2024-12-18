import 'package:finance_tracker/helper/color.dart';
import 'package:finance_tracker/pages/login.dart';
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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
          surface: AppColors.backgroundColor,
          primary: AppColors.primaryColor,
          onPrimary: AppColors.buttonTextColor,
        ),
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
        dividerTheme: const DividerThemeData(color: Colors.transparent),
      ),
      home: const LoginPage(),
    );
  }
}
