import 'package:finance_tracker/components/alert_dialog.dart';
import 'package:finance_tracker/components/delete_alert_dialog.dart';
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
        return AlertDialogForDelete(passwordController);
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
            return const AppAlertDialog('Error', 'Password is not correct');
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
                        .copyWith(color: const Color.fromARGB(169, 1, 18, 2)),
                  ),
                ),
              ),
            ),
            DrawerListTile(
              'Page with expenses',
              Icons.bar_chart,
              () => showPageWithExpenses(context),
            ),
            DrawerListTile(
              'Edit user data',
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
