class AppConstants {
  static const String passwordPattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).*$';
  static final RegExp passwordRegExp = RegExp(passwordPattern);
  // RegExp including check special character
  // r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{};\'\\:|,.<>/?]).*$";
}
