import 'package:finance_tracker/components/drawer_list_tile.dart';
import 'package:finance_tracker/pages/login.dart';
import 'package:finance_tracker/styles/colors.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void editUserData(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void deleteUser(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void showPageWithExpenses(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
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
              () {
                editUserData(context);
              },
            ),
            DrawerListTile(
              'Update user data',
              Icons.edit,
              () {
                showPageWithExpenses(context);
              },
            ),
            DrawerListTile(
              'Видалення акаунту',
              Icons.delete,
              () {
                deleteUser(context);
              },
            ),
            DrawerListTile(
              'Вийти',
              Icons.exit_to_app,
              () {
                deleteUser(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
