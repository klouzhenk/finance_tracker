import 'package:finance_tracker/pages/login.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
          labelLarge:
              TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
        ),
      ),
      home: const LoginPage(),
    );
  }
}
