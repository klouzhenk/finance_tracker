import 'package:finance_tracker/components/drawer_list_tile.dart';
import 'package:finance_tracker/pages/edit_user.dart';
import 'package:finance_tracker/pages/expenses.dart';
import 'package:finance_tracker/pages/login.dart';
import 'package:finance_tracker/providers/user_provider.dart';
import 'package:finance_tracker/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  void editUserData(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const EditUserPage()),
    );
  }

  void showPageWithExpenses(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ExpensePage()),
    );
  }

  void logout(BuildContext context, WidgetRef ref) {
    ref.read(userProvider.notifier).logout();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  Future<void> showDeleteConfirmationDialog(
      BuildContext context, WidgetRef ref) async {
    final TextEditingController passwordController = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm delete'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Input your password for confirmation'),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (passwordController.text.isNotEmpty) {
                  Navigator.pop(context, true);
                }
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      final isValid = await ref
          .read(userProvider.notifier)
          .validatePassword(passwordController.text);

      if (isValid) {
        await ref.read(userProvider.notifier).deleteUser();
        if (!context.mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        if (!context.mounted) return;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Password is not correct'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: Container(
        color: AppColors.secondaryColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 140,
              child: DrawerHeader(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    'Menu',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: AppColors.darkAccentColor),
                  ),
                ),
              ),
            ),
            DrawerListTile(
              'Сторінка з витратами',
              Icons.bar_chart,
              () => showPageWithExpenses(context),
            ),
            DrawerListTile(
              'Update user data',
              Icons.edit,
              () => editUserData(context),
            ),
            DrawerListTile(
              'Delete account',
              Icons.delete,
              () => showDeleteConfirmationDialog(context, ref),
            ),
            DrawerListTile(
              'Logout',
              Icons.exit_to_app,
              () => logout(context, ref),
            ),
          ],
        ),
      ),
    );
  }
}
