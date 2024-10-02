class EmailValidator {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static bool isValid(String email) {
    return _emailRegExp.hasMatch(email);
  }
}

class PasswordValidator {
  // Password must contain at least one lowercase letter,
  // one uppercase letter, and be between 8 to 64 characters long.
  // static final RegExp _passwordRegExp = RegExp(
  //   r'^(?=.*[a-z])(?=.*[A-Z]).{8,64}$',
  // );

  static bool isValid(String password) {
    return true;
    // return _passwordRegExp.hasMatch(password);
  }
}
