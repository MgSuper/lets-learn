import 'dart:async';

import 'package:boost_e_skills/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:boost_e_skills/features/auth/auth_error/auth_error.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginLoadingState(isLoading: false)) {
    on<ClickedLoginButtonEvent>(_clickedLoginButtonEvent);
    on<ClickedToNavigateRegisterEvent>(_clickedToNavigateRegisterEvent);
  }

  FutureOr<void> _clickedLoginButtonEvent(
      ClickedLoginButtonEvent event, Emitter<LoginState> emit) async {
    final FirebaseAuth auth = locator<FirebaseAuth>();
    emit(
      const LoginLoadingState(isLoading: true),
    );
    try {
      final email =
          '${event.userName.replaceAll(' ', '').toLowerCase()}@gmail.com';
      final password = event.password;
      final userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        emit(
          const LoginSuccessState(
            isLoading: false,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      emit(
        LoginErrorState(
          isLoading: false,
          authError: AuthError.from(e),
        ),
      );
    }
  }

  FutureOr<void> _clickedToNavigateRegisterEvent(
      ClickedToNavigateRegisterEvent event, Emitter<LoginState> emit) {
    emit(
      const NavigateToRegisterScreenState(isLoading: false),
    );
  }
}
