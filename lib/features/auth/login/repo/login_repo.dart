// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:boost_e_skills/features/auth/model/app_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRepo {
  final FirebaseAuth _firebaseAuth;
  LoginRepo({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<AppUserModel?> logIn(String name, String password) async {
    try {
      final nameToEmail = '${name.replaceAll(' ', '').toLowerCase()}@gmail.com';
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: nameToEmail,
        password: password,
      );
      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        return AppUserModel(
            id: firebaseUser.uid,
            email: nameToEmail,
            displayName: name,
            category: '');
      }
      return null;
    } on FirebaseAuthException catch (e) {
      return null;
    }
  }

  //signOutUser
  Future<void> signOutUser() async {
    final User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseAuth.instance.signOut();
    }
  }
}
