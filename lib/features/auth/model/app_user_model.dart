import 'package:cloud_firestore/cloud_firestore.dart';

class AppUserModel {
  final String id;
  final String email;
  final String displayName;
  final String category;

  AppUserModel(
      {required this.id,
      required this.email,
      required this.displayName,
      required this.category});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': displayName,
      'uid': id,
      category: 'category'
    };
  }

  // AppUserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
  //     : displayName = doc.data()!["displayName"],
  //       email = doc.data()!["email"],
  //       uid = doc.data()!["uid"],
  //       category = doc.data()!["category"];

  factory AppUserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return AppUserModel(
        id: doc.id,
        displayName: data['displayName'] ?? '',
        email: data['email'] ?? '',
        category: data['category']);
  }
}
