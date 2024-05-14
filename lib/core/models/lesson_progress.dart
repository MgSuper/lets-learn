// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class LessonProgress {
  final String id;
  final String userId;
  final String lessonId;
  // final String topicId;
  final bool isLearned;
  final DateTime? learnedOn;

  LessonProgress({
    required this.id,
    required this.userId,
    required this.lessonId,
    required this.isLearned,
    this.learnedOn,
  });

  factory LessonProgress.fromFirestore(Map<String, dynamic> data, String id) {
    return LessonProgress(
        id: id,
        userId: data['userId'] as String,
        lessonId: data['lessonId'] as String,
        // topicId: data['topicId'] as String,
        isLearned: data['isLearned'] as bool,
        learnedOn: (data['learnedOn'] as Timestamp?)?.toDate());
  }
}
