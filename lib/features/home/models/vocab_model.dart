// vocab_category.dart
class VocabCategory {
  final String id;
  final String name;

  VocabCategory({required this.id, required this.name});

  factory VocabCategory.fromFirestore(Map<String, dynamic> doc, String id) {
    return VocabCategory(
      id: id,
      name: doc['name'] as String,
    );
  }
}

// vocabulary_word.dart
class VocabularyWord {
  final String word;
  final String definition;
  final String pOne;
  final String pTwo;

  VocabularyWord({
    required this.word,
    required this.definition,
    required this.pOne,
    required this.pTwo,
  });

  factory VocabularyWord.fromFirestore(Map<String, dynamic> doc) {
    return VocabularyWord(
      word: doc['word'] as String,
      definition: doc['definition'] as String,
      pOne: doc['pOne'] as String,
      pTwo: doc['pTwo'] as String,
    );
  }
}
