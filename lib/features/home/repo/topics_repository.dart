import 'package:boost_e_skills/features/home/models/topics_model.dart';
import 'package:boost_e_skills/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TopicsRepository {
  final FirebaseFirestore _firestore = locator<FirebaseFirestore>();

  Future<Topics> fetchGrammarTopics() async {
    var snapshot = await _firestore.collection('topics').get();
    // Assuming your documents structure aligns with your Topics model
    return Topics.fromJson(snapshot.docs.first.data());
  }

  Future<Topics> fetchVocabularyTopics() async {
    var snapshot = await _firestore.collection('vocabularyTopics').get();
    return Topics.fromJson(snapshot.docs.first.data());
  }

  Future<Topics> fetchPhraseTopics() async {
    var snapshot = await _firestore.collection('phraseTopics').get();
    return Topics.fromJson(snapshot.docs.first.data());
  }
}
