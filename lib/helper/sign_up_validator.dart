class PasswordRequirements {
  static const int minLength = 4;
  static const bool requireUppercase = false;
  static const bool requireDigit = false;
  static const bool requireSpecialCharacter = false;
}

class SignUpValidator {
  static String? validateSignUpFields(
      String username, String password, String confirmedPassword) {
    if (username.isEmpty || password.isEmpty || confirmedPassword.isEmpty) {
      return 'Please fill all fields';
    }

    if (password != confirmedPassword) {
      return 'Passwords are not the same';
    }

    if (password.length < PasswordRequirements.minLength) {
      return 'Password must be at least ${PasswordRequirements.minLength} characters long';
    }

    if (PasswordRequirements.requireUppercase &&
        !password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (PasswordRequirements.requireDigit &&
        !password.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one digit';
    }

    if (PasswordRequirements.requireSpecialCharacter &&
        !password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return null;
  }
}
