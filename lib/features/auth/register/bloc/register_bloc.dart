import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:boost_e_skills/features/auth/auth_error/auth_error.dart';
import 'package:boost_e_skills/core/models/app_user_model.dart';
import 'package:boost_e_skills/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterLoadingState(isLoading: false)) {
    on<ClickedRegisterButtonEvent>(_clickedRegisterButtonEvent);
    on<ClickedToNavigateLoginEvent>(_clickedToNavigateLoginEvent);
  }

  FutureOr<void> _clickedToNavigateLoginEvent(
      ClickedToNavigateLoginEvent event, Emitter<RegisterState> emit) {
    emit(
      const NavigateToLoginScreenState(isLoading: false),
    );
  }

  FutureOr<void> _clickedRegisterButtonEvent(
      ClickedRegisterButtonEvent event, Emitter<RegisterState> emit) async {
    final FirebaseAuth auth = locator<FirebaseAuth>();
    emit(
      const RegisterLoadingState(isLoading: true),
    );
    try {
      final email =
          '${event.userName.replaceAll(' ', '').toLowerCase()}@gmail.com';
      final password = event.password;
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user!;
      // Save additional user data to Firestore
      AppUserModel newUser = AppUserModel(
          id: user.uid,
          email: email,
          displayName: event.userName,
          category: '');
      await saveUserData(newUser).whenComplete(
        () => emit(
          const RegisterSuccessState(
            isLoading: false,
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(
        RegisterErrorState(
          isLoading: false,
          authError: AuthError.from(e),
        ),
      );
    }
  }
}

Future<void> saveUserData(AppUserModel user) async {
  final FirebaseFirestore firestore = locator<FirebaseFirestore>();
  final usersRef = firestore.collection('users');
  await usersRef.doc(user.id).set({
    'uid': user.id,
    'email': user.email,
    'displayName': user.displayName,
    'category': user.category,
  });
}
