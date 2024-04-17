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
  final String? description;
  final String? word; // Optional field for idiom
  final String? usage; // Optional field for idiom usage
  final String? pOne;
  final String? pTwo;

  BasicLesson({
    required this.id,
    this.description,
    this.word,
    this.usage,
    this.pOne,
    this.pTwo,
  });

  BasicLesson.fromJson(Map<String, dynamic> json, [String? documentId])
      : id = documentId ??
            '', // Provide a default value or generate an ID as needed
        description = json['description'],
        word = json['word'],
        usage = json['usage'],
        pOne = json['pOne'],
        pTwo = json['pTwo'];

  BasicLesson.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id, // Assign the document ID
        description = snapshot.data()!.containsKey('description')
            ? snapshot.data()!['description']
            : null,
        word = snapshot.data()!.containsKey('word')
            ? snapshot.data()!['word']
            : null,
        usage = snapshot.data()!.containsKey('usage')
            ? snapshot.data()!['usage']
            : null,
        pOne = snapshot.data()!.containsKey('pOne')
            ? snapshot.data()!['pOne']
            : null,
        pTwo = snapshot.data()!.containsKey('pTwo')
            ? snapshot.data()!['pTwo']
            : null;
  // content = snapshot.data()?['content'],
  // front = snapshot.data()?['front'],
  // back = snapshot.data()?['back'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (description != null) data['description'] = description;
    if (word != null) data['word'] = word;
    if (usage != null) data['usage'] = usage;
    if (pOne != null) data['pOne'] = pOne;
    if (pTwo != null) data['pTwo'] = pTwo;
    return data;
  }
}
