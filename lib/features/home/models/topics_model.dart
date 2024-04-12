// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Topics {
  String topic;
  List<BasicLesson>? basicLesson;

  Topics({required this.topic, this.basicLesson});

  Topics.fromJson(Map<String, dynamic> json)
      : topic = json['topic'] as String,
        basicLesson = (json['basicLesson'] as List<dynamic>?)
            ?.map((e) => BasicLesson.fromJson(e as Map<String, dynamic>))
            .toList();

  Topics.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : topic = snapshot.data()?['topic'] ?? '',
        basicLesson = snapshot.data()?['basicLesson'] != null
            ? List<BasicLesson>.from(
                (snapshot.data()!['basicLesson'] as List).map(
                  (x) => BasicLesson.fromJson(x as Map<String, dynamic>),
                ),
              )
            : [];

  Map<String, dynamic> toJson() {
    return {
      'topic': topic,
      'basicLesson': basicLesson?.map((x) => x.toJson()).toList(),
    };
  }
}

class BasicLesson {
  final String id;
  final String content;

  BasicLesson({
    required this.id,
    required this.content,
  });

  BasicLesson.fromJson(Map<String, dynamic> json, [String? documentId])
      : id = documentId ??
            '', // Provide a default value or generate an ID as needed
        content = json['content'];

  BasicLesson.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id, // Assign the document ID
        content = snapshot['content'];

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      // Note: Typically, you don't need to include the ID in toJson,
      // unless you're using it in a way that requires it.
    };
  }
}
