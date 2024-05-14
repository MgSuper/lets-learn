// ignore_for_file: public_member_api_docs, sort_constructors_first
// vocab_category.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class VocabCategory {
  final String id;
  final String name;
  final DateTime timestamp;

  VocabCategory({
    required this.id,
    required this.name,
    required this.timestamp,
  });

  factory VocabCategory.fromFirestore(Map<String, dynamic> doc, String id) {
    return VocabCategory(
      id: id,
      name: doc['name'] as String,
      timestamp: (doc['timestamp'] as Timestamp).toDate(),
    );
  }
}

// vocabulary_word.dart
class VocabularyWord {
  final String id;
  final String word;
  final String definition;
  final String pOne;
  final String pTwo;
  final DateTime timestamp;

  VocabularyWord({
    required this.id,
    required this.word,
    required this.definition,
    required this.pOne,
    required this.pTwo,
    required this.timestamp,
  });

  factory VocabularyWord.fromFirestore(Map<String, dynamic> data, String id) {
    return VocabularyWord(
      id: id,
      word: data['word'] as String,
      definition: data['definition'] as String,
      pOne: data['pOne'] as String,
      pTwo: data['pTwo'] as String,
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}
