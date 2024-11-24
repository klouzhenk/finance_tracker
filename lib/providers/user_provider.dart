import 'package:finance_tracker/database/helper.dart';
import 'package:finance_tracker/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  void loadUser(int id, String username, String password) {
    state = User(id: id, username: username, password: password);
  }

  void logout() {
    state = null;
  }

  Future<void> updateUsername(String newUsername) async {
    if (state == null) {
      return;
    }

    await DatabaseHelper.instance.updateUser(state!.id, username: newUsername);
    loadUser(state!.id, newUsername, state!.password);
  }

  Future<void> updatePassword(String newPassword) async {
    if (state == null) {
      return;
    }

    await DatabaseHelper.instance.updateUser(state!.id, password: newPassword);
    loadUser(state!.id, state!.username, newPassword);
  }

  Future<bool> deleteUser() async {
    if (state == null) {
      return false;
    }

    await DatabaseHelper.instance.deleteUser(state!.id);
    return true;
  }

  Future<bool> validatePassword(String password) async {
    if (state == null) {
      return false;
    }
    return state!.password == password;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User?>(
  (ref) => UserNotifier(),
);
