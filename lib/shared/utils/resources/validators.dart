// validators.dart
import 'package:boost_e_skills/shared/utils/resources/app_constants.dart';

class Validators {
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password can\'t be empty';
    }
    if (value.length < 6) {
      return 'Password can\'t less than 6 words';
    }
    if (!AppConstants.passwordRegExp.hasMatch(value)) {
      return 'Password must contain at least one uppercase, one lowercase and one number';
    }
    return null;
  }

  static String? validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name can\'t be empty';
    }
    if (value.length <= 3) {
      return 'Name can\'t less than 3 words';
    }
    return null;
  }
}
