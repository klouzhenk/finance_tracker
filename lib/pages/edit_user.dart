import 'package:finance_tracker/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finance_tracker/providers/user_provider.dart';

class EditUserPage extends ConsumerWidget {
  const EditUserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User'),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _EditableField(
              title: 'Username',
              currentValue: user!.username,
              onEdit: () {
                showDialog(
                  context: context,
                  builder: (context) => _EditUsernameDialog(
                    currentUsername: user.username,
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

            // Поле для пароля
            _EditableField(
              title: 'Password',
              currentValue: '•••••••',
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
  final String currentValue;
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
                title,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              Text(
                currentValue,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onEdit,
          icon: const Icon(Icons.edit),
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
      title: const Text('Edit Username'),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(labelText: 'Username'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onSave(_controller.text.trim());
            Navigator.pop(context);
          },
          child: const Text('Save'),
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
      title: const Text('Edit Password'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _newPasswordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'New Password'),
          ),
          TextField(
            controller: _confirmPasswordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Confirm Password'),
          ),
          if (_errorText != null) ...[
            const SizedBox(height: 8),
            Text(
              _errorText!,
              style: const TextStyle(color: Colors.red),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _save,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
