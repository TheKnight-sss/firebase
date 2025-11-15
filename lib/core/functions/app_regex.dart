class AppRegex {
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(password);
  }

  static bool isValidPhoneNumber(String phoneNumber) {
    return RegExp(r'^\+?[0-9]{7,15}$').hasMatch(phoneNumber);
  }
}
