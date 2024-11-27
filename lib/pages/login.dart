import 'package:finance_tracker/components/form_btn.dart';
import 'package:finance_tracker/components/form_text_field.dart';
import 'package:finance_tracker/database/helper.dart';
import 'package:finance_tracker/helper/snack_bar.dart';
import 'package:finance_tracker/pages/expenses.dart';
import 'package:finance_tracker/pages/registration.dart';
import 'package:finance_tracker/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> onLogin() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      SnackBarHelper.showSnackBar(
          context, 'Please enter both username and password');
      return;
    }

    final user = await DatabaseHelper.instance.getUser(username, password);

    if (user != null) {
      ref
          .read(userProvider.notifier)
          .loadUser(user.id, user.username, user.password);
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ExpensePage()),
      );
    } else {
      if (!mounted) return;
      SnackBarHelper.showSnackBar(context, 'Invalid username or password');
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
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
                'Expense Tracker',
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
