import 'package:cloud_firestore/cloud_firestore.dart';

class LessonProgress {
  final String id;
  final String userId;
  final String lessonId;
  final String topicId;
  final bool isCompleted;
  final DateTime? completedOn;

  LessonProgress({
    required this.id,
    required this.userId,
    required this.lessonId,
    required this.topicId,
    required this.isCompleted,
    this.completedOn,
  });

  factory LessonProgress.fromFirestore(Map<String, dynamic> data, String id) {
    return LessonProgress(
      id: id,
      userId: data['userId'] as String,
      lessonId: data['lessonId'] as String,
      topicId: data['topicId'] as String,
      isCompleted: data['isCompleted'] as bool,
      completedOn: (data['completedOn'] as Timestamp?)?.toDate(),
    );
  }
}
