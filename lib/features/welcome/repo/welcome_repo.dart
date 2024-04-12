import 'package:shared_preferences/shared_preferences.dart';

class WelcomeRepo {
  final SharedPreferences sharedPreferences;

  WelcomeRepo({required this.sharedPreferences});

  bool get hasCompletedWelcome =>
      sharedPreferences.getBool('hasCompletedWelcome') ?? false;

  Future<void> completeWelcome() async {
    await sharedPreferences.setBool('hasCompletedWelcome', true);
  }
}
