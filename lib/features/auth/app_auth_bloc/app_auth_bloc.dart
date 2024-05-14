// step_4
import 'package:boost_e_skills/features/auth/auth_error/auth_error.dart';
import 'package:boost_e_skills/features/auth/auth_repo/auth_repo.dart';
import 'package:boost_e_skills/core/models/app_user_model.dart';
import 'package:boost_e_skills/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show immutable;

part 'app_auth_event.dart';
part 'app_auth_state.dart';

class AppAuthBloc extends Bloc<AppAuthEvent, AppAuthState> {
  final AuthRepo authRepo;
  AppAuthBloc({required this.authRepo})
      : super(
          const AppAuthStateLoggedOut(
            isLoading: false,
          ),
        ) {
    // log out event
    on<AppAuthEventLogOut>(
      (event, emit) async {
        // start loading
        emit(
          const AppAuthStateLoggedOut(isLoading: true),
        );
        // log the user out
        await FirebaseAuth.instance.signOut();
        // log the user out in UI as well
        emit(
          const AppAuthStateLoggedOut(
            isLoading: false,
          ),
        );
      },
    );
    on<AppAuthEventGoToRegistration>(
      (event, emit) {
        emit(
          const AppAuthStateIsRegistrationView(
            isLoading: false,
          ),
        );
      },
    );
    on<AppAuthEventLogIn>(
      (event, emit) async {
        emit(
          const AppAuthStateLoggedOut(isLoading: true),
        );
        try {
          final email =
              '${event.userName.replaceAll(' ', '').toLowerCase()}@gmail.com';
          final password = event.password;
          final userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);
          final user = userCredential.user!;

          emit(
            AppAuthStateLoggedIn(
              isLoading: false,
              user: user,
            ),
          );
        } on FirebaseAuthException catch (e) {
          emit(
            AppAuthStateLoggedOut(
              isLoading: false,
              authError: AuthError.from(e),
            ),
          );
        }
      },
    );
    on<AppAuthEventGoToLogIn>(
      (event, emit) {
        emit(
          const AppAuthStateLoggedOut(isLoading: false),
        );
      },
    );
    on<AppAuthEventRegister>(
      (event, emit) async {
        emit(
          const AppAuthStateIsRegistrationView(isLoading: true),
        );
        try {
          final email =
              '${event.userName.replaceAll(' ', '').toLowerCase()}@gmail.com';
          final password = event.password;
          final userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
          await saveUserData(newUser);
          emit(
            const AppAuthStateRegistered(
              isLoading: false,
            ),
          );
        } on FirebaseAuthException catch (e) {
          emit(
            AppAuthStateIsRegistrationView(
              isLoading: false,
              authError: AuthError.from(e),
            ),
          );
        }
      },
    );
    on<AppAuthEventInitialize>(
      (event, emit) async {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          emit(
            const AppAuthStateLoggedOut(
              isLoading: false,
            ),
          );
        } else {
          emit(
            AppAuthStateLoggedIn(
              isLoading: false,
              user: user,
            ),
          );
        }
      },
    );
  }

  Future<void> saveUserData(AppUserModel user) async {
    final FirebaseFirestore firestore = locator<FirebaseFirestore>();
    final usersRef = firestore.collection('users');
    await usersRef.doc(user.id).set({
      'id': user.id,
      'email': user.email,
      'displayName': user.displayName,
      'category': user.category,
    });
  }

  Future<AppUserModel> _getUser(String userID) =>
      FirebaseFirestore.instance.collection('users').doc(userID).get().then(
            (userInfo) => AppUserModel.fromFirestore(userInfo),
          );
}
