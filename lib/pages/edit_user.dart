import 'package:finance_tracker/components/alert_dialog_title.dart';
import 'package:finance_tracker/components/app_bar.dart';
import 'package:finance_tracker/components/drawer.dart';
import 'package:finance_tracker/styles/colors.dart';
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
            _EditableField(
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
            _EditableField(
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

class _EditableField extends StatelessWidget {
  final String title;
  final String? currentValue;
  final bool isPassword;
  final VoidCallback onEdit;

  const _EditableField({
    required this.title,
    required this.currentValue,
    required this.onEdit,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit ${title.toLowerCase()}',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppColors.accentColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Current ${title.toLowerCase()}: ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w400),
                    overflow: TextOverflow.ellipsis,
                  ),
                  currentValue != null
                      ? Text(
                          currentValue!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w300),
                          overflow: TextOverflow.ellipsis,
                        )
                      : const Icon(Icons.visibility_off),
                ],
              )
            ],
          ),
        ),
        IconButton(
          onPressed: onEdit,
          icon: const Icon(
            Icons.edit,
            size: 28,
            color: AppColors.darkAccentColor,
          ),
        ),
      ],
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
        TextField(
          controller: _controller,
          style: const TextStyle(color: AppColors.buttonTextColor),
          decoration: const InputDecoration(
            labelText: 'Username',
            labelStyle: TextStyle(color: Color.fromARGB(160, 255, 255, 255)),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(160, 255, 255, 255), width: 0.0),
            ),
            border: OutlineInputBorder(),
          ),
        ),
      ]),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Cancel',
            style: TextStyle(color: AppColors.buttonTextColor),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onSave(_controller.text.trim());
            Navigator.pop(context);
          },
          child: const Text(
            'Save',
            style: TextStyle(
              color: AppColors.accentColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
            ),
          ),
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
          TextField(
            controller: _newPasswordController,
            obscureText: true,
            style: const TextStyle(color: AppColors.buttonTextColor),
            decoration: const InputDecoration(
              labelText: 'New password',
              labelStyle: TextStyle(color: Color.fromARGB(160, 255, 255, 255)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(160, 255, 255, 255), width: 0.0),
              ),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _confirmPasswordController,
            obscureText: true,
            style: const TextStyle(color: AppColors.buttonTextColor),
            decoration: const InputDecoration(
              labelText: 'Confirm Password',
              labelStyle: TextStyle(color: Color.fromARGB(160, 255, 255, 255)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(160, 255, 255, 255), width: 0.0),
              ),
              border: OutlineInputBorder(),
            ),
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
        ElevatedButton(
          onPressed: _save,
          child: const Text(
            'Save',
            style: TextStyle(
              color: AppColors.accentColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
            ),
          ),
        ),
      ],
    );
  }
}
