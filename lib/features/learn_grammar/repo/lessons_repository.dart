import 'package:boost_e_skills/core/models/topics_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LessonsRepository {
  final FirebaseFirestore firestore;

  LessonsRepository({required this.firestore});

  Future<bool> isLessonLearned(String userId, String lessonId) async {
    try {
      QuerySnapshot snapshot = await firestore
          .collection('user_progress')
          .where('userId', isEqualTo: userId)
          .where('lessonId', isEqualTo: lessonId)
          .where('isLearned', isEqualTo: true)
          .limit(1)
          .get();

      return snapshot.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<void> markLessonAsLearned(String userId, String lessonId) async {
    try {
      await firestore.collection('user_progress').add({
        'userId': userId,
        'lessonId': lessonId,
        'isLearned': true,
        'learnedOn':
            FieldValue.serverTimestamp(), // Uses the server's timestamp
      });
    } catch (e) {
      print('Error marking lesson as learned: $e');
    }
  }

  Future<BasicLesson> fetchLessonById(String lessonId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection('lessons').doc(lessonId).get();
      if (snapshot.exists && snapshot.data() != null) {
        return BasicLesson.fromSnapshot(snapshot);
      } else {
        throw Exception('Lesson not found');
      }
    } catch (e) {
      print('Error fetching lesson: $e');
      throw Exception('Failed to fetch lesson');
    }
  }
}
