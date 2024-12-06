import 'package:finance_tracker/components/alert_dialog_title.dart';
import 'package:finance_tracker/components/app_bar.dart';
import 'package:finance_tracker/components/drawer.dart';
import 'package:finance_tracker/components/edit_user_page/dialog_text_field.dart';
import 'package:finance_tracker/components/edit_user_page/editable_field.dart';
import 'package:finance_tracker/components/edit_user_page/save_button.dart';
import 'package:finance_tracker/helper/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finance_tracker/providers/user_provider.dart';

class EditUserPage extends ConsumerWidget {
  const EditUserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Scaffold(
      appBar: const CustomAppBar("Edit user information"),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EditableField(
              title: 'Username',
              currentValue: user?.username,
              onEdit: () {
                showDialog(
                  context: context,
                  builder: (context) => _EditUsernameDialog(
                    currentUsername: user != null ? user.username : '',
                    onSave: (newUsername) {
                      ref
                          .read(userProvider.notifier)
                          .updateUsername(newUsername);
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            EditableField(
              title: 'Password',
              currentValue: null,
              isPassword: true,
              onEdit: () {
                showDialog(
                  context: context,
                  builder: (context) => _EditPasswordDialog(
                    onSave: (newPassword) {
                      ref
                          .read(userProvider.notifier)
                          .updatePassword(newPassword);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _EditUsernameDialog extends StatefulWidget {
  final String currentUsername;
  final Function(String) onSave;

  const _EditUsernameDialog({
    required this.currentUsername,
    required this.onSave,
  });

  @override
  State<_EditUsernameDialog> createState() => _EditUsernameDialogState();
}

class _EditUsernameDialogState extends State<_EditUsernameDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentUsername);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const AlertDialogTitle('Edit Username'),
      backgroundColor: AppColors.accentColor,
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        const SizedBox(height: 20),
        AlertDialogTextField(_controller, 'Username')
      ]),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Cancel',
            style: TextStyle(color: AppColors.buttonTextColor),
          ),
        ),
        AlertDialogSaveButton(
          () {
            widget.onSave(_controller.text.trim());
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class _EditPasswordDialog extends StatefulWidget {
  final Function(String) onSave;

  const _EditPasswordDialog({required this.onSave});

  @override
  State<_EditPasswordDialog> createState() => _EditPasswordDialogState();
}

class _EditPasswordDialogState extends State<_EditPasswordDialog> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _save() {
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        _errorText = 'All fields are required';
      });
      return;
    }

    if (newPassword != confirmPassword) {
      setState(() {
        _errorText = 'Passwords do not match';
      });
      return;
    }

    widget.onSave(newPassword);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const AlertDialogTitle('Edit password'),
      backgroundColor: AppColors.accentColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          AlertDialogTextField(
            _newPasswordController,
            'New password',
            obscureText: true,
          ),
          const SizedBox(height: 16),
          AlertDialogTextField(
            _confirmPasswordController,
            'Confirm password',
            obscureText: true,
          ),
          if (_errorText != null) ...[
            const SizedBox(height: 8),
            Text(
              _errorText!,
              style: const TextStyle(color: Color.fromARGB(255, 246, 190, 186)),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: AppColors.buttonTextColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        AlertDialogSaveButton(_save),
      ],
    );
  }
}
