// on the entire AppAuthState
import 'package:boost_e_skills/features/auth/app_auth_bloc/app_auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension GetUser on AppAuthState {
  User? get user {
    final cls = this;
    if (cls is AppAuthStateLoggedIn) {
      return cls.user;
    } else {
      return null;
    }
  }
}
