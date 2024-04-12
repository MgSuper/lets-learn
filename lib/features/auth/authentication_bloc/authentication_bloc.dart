// authentication_bloc.dart
import 'package:boost_e_skills/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationState.uninitialized) {
    on<AuthenticationEvent>((event, emit) {
      if (event == AuthenticationEvent.appStarted) {
        final isAuthenticated = _checkIfAuthenticated();
        if (isAuthenticated) {
          emit(AuthenticationState.authenticated);
        } else {
          emit(AuthenticationState.unauthenticated);
        }
        // emit(await _checkIfAuthenticated());
      }
    });
  }

  bool _checkIfAuthenticated() {
    final user = locator<FirebaseAuth>().currentUser;
    if (user != null) {
      // User is signed in
      return true;
    } else {
      // No user is signed in
      return false;
    }
  }
}
