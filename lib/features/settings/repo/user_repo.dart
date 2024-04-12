import 'package:boost_e_skills/features/auth/model/app_user_model.dart';
import 'package:boost_e_skills/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseFirestore _firebaseFirestore = locator<FirebaseFirestore>();
  final FirebaseAuth _firebaseAuth = locator<FirebaseAuth>();

  UserRepository({firebaseFirestore});

  Future<AppUserModel> getUser(String userId) async {
    try {
      DocumentSnapshot doc =
          await _firebaseFirestore.collection('users').doc(userId).get();
      return AppUserModel.fromFirestore(doc);
    } catch (e) {
      throw Exception("Error fetching user");
    }
  }

  Future<void> signOutUser() async {
    await _firebaseAuth.signOut();
  }
}
