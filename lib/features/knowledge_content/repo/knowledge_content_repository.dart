import 'package:boost_e_skills/features/knowledge_content/model/knowledge_content.dart';
import 'package:boost_e_skills/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KnowledgeContentRepository {
  FirebaseFirestore firestore = locator<FirebaseFirestore>();

  DocumentSnapshot? _lastAllDocument;
  DocumentSnapshot? _lastCategoryDocument;

  KnowledgeContentRepository({required this.firestore});

  // DocumentSnapshot? _lastDocument;

  // Stream<List<KnowledgeContentModel>> getKnowledgeContents() {
  //   return firestore
  //       .collection(
  //         'knowledge_contents',
  //       )
  //       .orderBy('timestamp', descending: true)
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.docs
  //         .map((doc) => KnowledgeContentModel.fromFirestore(doc.data(), doc.id))
  //         .toList()
  //         .cast<KnowledgeContentModel>();
  //   });
  // }

  // Method to fetch the initial page
  // Future<List<KnowledgeContentModel>> fetchInitialPage(int limit) async {
  //   final querySnapshot = await firestore
  //       .collection('knowledge_contents')
  //       .orderBy('timestamp', descending: true)
  //       .limit(limit)
  //       .get();
  //   if (querySnapshot.docs.isNotEmpty) {
  //     _lastDocument = querySnapshot.docs.last;
  //   }
  //   return querySnapshot.docs
  //       .map((doc) => KnowledgeContentModel.fromFirestore(doc.data(), doc.id))
  //       .toList();
  // }

  // // Method to fetch the next page
  // Future<List<KnowledgeContentModel>> fetchNextPage(int limit) async {
  //   if (_lastDocument == null) return [];
  //   final querySnapshot = await firestore
  //       .collection('knowledge_contents')
  //       .orderBy('timestamp', descending: true)
  //       .startAfterDocument(_lastDocument!)
  //       .limit(limit)
  //       .get();
  //   if (querySnapshot.docs.isNotEmpty) {
  //     _lastDocument = querySnapshot.docs.last;
  //   }
  //   return querySnapshot.docs
  //       .map((doc) => KnowledgeContentModel.fromFirestore(doc.data(), doc.id))
  //       .toList();
  // }

  // // Optionally, a reset method to restart from the initial page
  // void resetPagination() {
  //   _lastDocument = null;
  // }

  // Future<void> likeContent(
  //     String contentId, String userId, bool isLiked) async {
  //   DocumentReference ref =
  //       firestore.collection('knowledge_contents').doc(contentId);
  //   return firestore.runTransaction((transaction) async {
  //     DocumentSnapshot snapshot = await transaction.get(ref);
  //     Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
  //     List<String> likedByUsers =
  //         List.from(data['likedByUsers'] as List<dynamic>);
  //     if (isLiked) {
  //       likedByUsers.add(userId); // Add user ID to likedByUsers list
  //     } else {
  //       likedByUsers.remove(userId); // Remove user ID from likedByUsers list
  //     }
  //     transaction.update(ref, {'likedByUsers': likedByUsers});
  //   });
  // }

  // Future<void> addComment(String contentId, String comment) async {
  //   DocumentReference ref =
  //       firestore.collection('knowledge_contents').doc(contentId);
  //   return firestore.runTransaction((transaction) async {
  //     transaction.update(ref, {
  //       'comments': FieldValue.arrayUnion([comment])
  //     });
  //   });
  // }

  // Future<void> likeContent(String contentId, String userId) async {
  //   DocumentReference ref =
  //       firestore.collection('knowledge_contents').doc(contentId);
  //   return firestore.runTransaction((transaction) async {
  //     DocumentSnapshot snapshot = await transaction.get(ref);
  //     Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
  //     List<String> likedByUsers =
  //         List.from(data['likedByUsers'] as List<dynamic>);
  //     if (likedByUsers.contains(userId)) {
  //       likedByUsers.remove(userId); // Remove user ID from likedByUsers list
  //     } else {
  //       likedByUsers.add(userId); // Add user ID to likedByUsers list
  //     }
  //     transaction.update(ref, {'likedByUsers': likedByUsers});
  //   });
  // }

  // // Fetch initial set of content, or continue pagination for "All" category
  // Future<List<KnowledgeContentModel>> fetchAllContents(int limit) async {
  //   Query query = firestore
  //       .collection('knowledge_contents')
  //       .orderBy('timestamp', descending: true)
  //       .limit(limit);

  //   if (_lastAllDocument != null) {
  //     query = query.startAfterDocument(_lastAllDocument!);
  //   }

  //   final querySnapshot = await query.get();

  //   if (querySnapshot.docs.isNotEmpty) {
  //     _lastAllDocument = querySnapshot.docs.last;
  //   }

  //   return querySnapshot.docs
  //       .map((doc) => KnowledgeContentModel.fromFirestore(
  //           doc.data() as Map<String, dynamic>, doc.id))
  //       .toList();
  // }

  // // Fetch or paginate content filtered by category
  // Future<List<KnowledgeContentModel>> fetchByCategoryWithPagination(
  //     String category, int limit) async {
  //   Query query = firestore
  //       .collection('knowledge_contents')
  //       .where('category', isEqualTo: category)
  //       .orderBy('timestamp', descending: true)
  //       .limit(limit);

  //   if (_lastCategoryDocument != null) {
  //     query = query.startAfterDocument(_lastCategoryDocument!);
  //   }

  //   final querySnapshot = await query.get();

  //   if (querySnapshot.docs.isNotEmpty) {
  //     _lastCategoryDocument = querySnapshot.docs.last;
  //   }

  //   return querySnapshot.docs
  //       .map((doc) => KnowledgeContentModel.fromFirestore(
  //           doc.data() as Map<String, dynamic>, doc.id))
  //       .toList();
  // }

  // // Reset pagination markers
  // void resetPagination({bool isCategory = false}) {
  //   if (isCategory) {
  //     _lastCategoryDocument = null;
  //   } else {
  //     _lastAllDocument = null;
  //   }
  // }

  // Real-time like toggle with Firestore transactions
  Future<void> likeContent(String contentId, String userId) async {
    DocumentReference ref =
        firestore.collection('knowledge_contents').doc(contentId);
    return firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(ref);
      Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
      List<String> likedByUsers =
          List.from(data['likedByUsers'] as List<dynamic>);
      if (likedByUsers.contains(userId)) {
        likedByUsers.remove(userId); // Remove user ID from likedByUsers list
      } else {
        likedByUsers.add(userId); // Add user ID to likedByUsers list
      }
      transaction.update(ref, {'likedByUsers': likedByUsers});
    });
  }

  // Fetch all contents initially or continue pagination
  Future<List<KnowledgeContentModel>> fetchAllContents(int limit) async {
    Query query = firestore
        .collection('knowledge_contents')
        .orderBy('timestamp', descending: true)
        .limit(limit);

    // If there's a previous pagination point
    if (_lastAllDocument != null) {
      query = query.startAfterDocument(_lastAllDocument!);
    }

    final querySnapshot = await query.get();
    if (querySnapshot.docs.isNotEmpty) {
      _lastAllDocument = querySnapshot.docs.last;
    }

    return querySnapshot.docs
        .map((doc) => KnowledgeContentModel.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  // Fetch contents by category with pagination
  Future<List<KnowledgeContentModel>> fetchByCategoryWithPagination(
      String category, int limit) async {
    Query query = firestore
        .collection('knowledge_contents')
        .where('category', isEqualTo: category)
        .orderBy('timestamp', descending: true)
        .limit(limit);

    // If there's a previous pagination point
    if (_lastCategoryDocument != null) {
      query = query.startAfterDocument(_lastCategoryDocument!);
    }

    final querySnapshot = await query.get();
    if (querySnapshot.docs.isNotEmpty) {
      _lastCategoryDocument = querySnapshot.docs.last;
    }

    return querySnapshot.docs
        .map((doc) => KnowledgeContentModel.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  // Reset pagination markers
  void resetPagination({bool isCategory = false}) {
    if (isCategory) {
      _lastCategoryDocument = null;
    } else {
      _lastAllDocument = null;
    }
  }

  // Stream-based fetching of all contents
  Stream<List<KnowledgeContentModel>> streamAllContents(int limit) {
    Query query = firestore
        .collection('knowledge_contents')
        .orderBy('timestamp', descending: true)
        .limit(limit);

    return query.snapshots().map((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        _lastAllDocument = querySnapshot.docs.last;
      }

      return querySnapshot.docs
          .map((doc) => KnowledgeContentModel.fromFirestore(
              doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }

  // Stream-based fetching of contents by category
  Stream<List<KnowledgeContentModel>> streamByCategoryWithPagination(
      String category, int limit) {
    Query query = firestore
        .collection('knowledge_contents')
        .where('category', isEqualTo: category)
        .orderBy('timestamp', descending: true)
        .limit(limit);

    return query.snapshots().map((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        _lastCategoryDocument = querySnapshot.docs.last;
      }

      return querySnapshot.docs
          .map((doc) => KnowledgeContentModel.fromFirestore(
              doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }
}
