import 'package:boost_e_skills/core/models/lesson_progress.dart';
import 'package:boost_e_skills/core/models/vocab_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:boost_e_skills/locator.dart';

class VocabularyRepository {
  final FirebaseFirestore firestore = locator<FirebaseFirestore>();

  Future<VocabularyWord> fetchVocabulary(
      String categoryId, String vocabId) async {
    DocumentSnapshot<Map<String, dynamic>> doc = await firestore
        .collection('vocabulary_categories')
        .doc(categoryId)
        .collection('vocabularies')
        .doc(vocabId)
        .get();

    if (!doc.exists) {
      throw Exception("Lesson not found");
    }

    return VocabularyWord.fromFirestore(
        doc.data() as Map<String, dynamic>, doc.id);
  }

  Future<bool> checkIfLessonIsLearned(String userId, String lessonId) async {
    var snapshot = await firestore
        .collection('user_progress')
        .where('userId', isEqualTo: userId)
        .where('lessonId', isEqualTo: lessonId)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  Future<void> markVocabAsLearned(String userId, String vocabId) async {
    await firestore.collection('user_progress').doc('${userId}_$vocabId').set({
      'userId': userId,
      'lessonId': vocabId,
      'isLearned': true,
      'learnedOn': FieldValue.serverTimestamp(),
    });
  }

  Future<List<VocabularyWord>> fetchVocabularies(String categoryId) async {
    var snapshot = await firestore
        .collection('vocabulary_categories')
        .doc(categoryId)
        .collection('vocabularies')
        .orderBy('timestamp', descending: true)
        .get();
    return snapshot.docs
        .map((doc) => VocabularyWord.fromFirestore(doc.data(), doc.id))
        .toList();
  }

  Future<List<LessonProgress>> fetchUserProgress(String userId) async {
    QuerySnapshot snapshot = await firestore
        .collection('user_progress')
        .where('userId', isEqualTo: userId)
        .orderBy('learnedOn', descending: true)
        .get();
    return snapshot.docs.map((doc) {
      return LessonProgress.fromFirestore(
          doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }
}
