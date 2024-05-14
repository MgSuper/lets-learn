import 'package:boost_e_skills/core/models/lesson_progress.dart';
import 'package:boost_e_skills/core/models/topics_model.dart';
import 'package:boost_e_skills/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeRepository {
  final FirebaseFirestore firestore = locator<FirebaseFirestore>();

  Future<Topics> fetchUpdatedTopics(String topicId) async {
    DocumentSnapshot<Map<String, dynamic>> topicSnapshot =
        await firestore.collection('topics').doc(topicId).get();
    if (!topicSnapshot.exists) {
      throw Exception("Topic not found");
    }

    QuerySnapshot<Map<String, dynamic>> lessonsSnapshot = await firestore
        .collection('topics')
        .doc(topicId)
        .collection('basic_lessons')
        .orderBy('timestamp', descending: true)
        .get();

    List<BasicLesson> lessons = lessonsSnapshot.docs
        .map((doc) => BasicLesson.fromSnapshot(doc))
        .toList();
    Topics topic = Topics.fromSnapshot(topicSnapshot);
    topic.basicLesson = lessons;
    return topic;
  }

  Future<List<LessonProgress>> fetchUserProgress(String userId) async {
    QuerySnapshot snapshot = await firestore
        .collection('user_progress')
        .where('userId', isEqualTo: userId)
        .orderBy('learnedOn', descending: true)
        .get();

    List<LessonProgress> progressList = snapshot.docs
        .map((doc) => LessonProgress.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id))
        .toList();
    return progressList;
  }
}
