import 'package:finance_tracker/components/form_btn.dart';
import 'package:finance_tracker/components/form_text_field.dart';
import 'package:finance_tracker/database/helper.dart';
import 'package:finance_tracker/helper/snack_bar.dart';
import 'package:finance_tracker/pages/home.dart';
import 'package:finance_tracker/pages/registration.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> onLogin() async {
    final username = _emailController.text;
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      SnackBarHelper.showSnackBar(
          context: context, text: 'Please enter both username and password');
      return;
    }

    final isValidUser =
        await DatabaseHelper.instance.checkUser(username, password);

    if (isValidUser) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      SnackBarHelper.showSnackBar(
          context: context, text: 'Invalid username or password');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Finance Tracker',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 48),
              CustomTextField(
                controller: _emailController,
                labelText: 'Email',
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _passwordController,
                labelText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 4),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegistrationPage()),
                  );
                },
                child: const Text("Don't have an account? Sign up"),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: FormButtonSubmit(
                    onPressed: onLogin,
                    text: 'Login',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
