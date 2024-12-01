import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

class PasswordHelper {
  static String generateSalt([int length = 16]) {
    final random = Random.secure();
    final values = List<int>.generate(length, (i) => random.nextInt(256));
    return base64Url.encode(values);
  }

  static String hashPassword(String password, String salt) {
    final bytes = utf8.encode(password + salt);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static bool verifyPassword(
      String password, String salt, String hashedPassword) {
    final newHash = hashPassword(password, salt);
    return newHash == hashedPassword;
  }
}
