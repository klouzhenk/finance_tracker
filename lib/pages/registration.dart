import 'package:finance_tracker/components/form_btn.dart';
import 'package:finance_tracker/components/form_text_field.dart';
import 'package:finance_tracker/helper/sign_up_validator.dart';
import 'package:finance_tracker/helper/snack_bar.dart';
import 'package:finance_tracker/database/helper.dart';
import 'package:finance_tracker/pages/expenses.dart';
import 'package:finance_tracker/pages/login.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  RegistrationPageState createState() {
    return RegistrationPageState();
  }
}

class RegistrationPageState extends State<RegistrationPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future<void> onSignUp() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final confirmedPassword = _confirmPasswordController.text;

    final errorMessage = SignUpValidator.validateSignUpFields(
        username, password, confirmedPassword);

    if (errorMessage != null) {
      SnackBarHelper.showSnackBar(context, errorMessage);
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    try {
      bool userExists =
          await DatabaseHelper.instance.checkUserExisting(username);

      if (userExists) {
        if (!mounted) return;
        Navigator.pop(context);
        SnackBarHelper.showSnackBar(
            context, 'Username already exists with this name');
        return;
      }

      await DatabaseHelper.instance.insertUser(username, password);
      if (!mounted) return;
      Navigator.pop(context);

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ExpensePage()),
        );
      }
    } catch (e) {
      Navigator.pop(context);
      SnackBarHelper.showSnackBar(context, 'An error occurred: $e');
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                controller: _usernameController,
                labelText: 'Username',
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _passwordController,
                labelText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _confirmPasswordController,
                labelText: 'Confirm Password',
                obscureText: true,
              ),
              const SizedBox(height: 4),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text("Already have an account? Login"),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: FormButtonSubmit(
                    onPressed: onSignUp,
                    text: 'Sign Up',
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
