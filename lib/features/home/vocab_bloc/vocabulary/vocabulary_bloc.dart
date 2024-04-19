import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:boost_e_skills/features/home/models/vocab_model.dart';
import 'package:boost_e_skills/locator.dart';
import 'package:boost_e_skills/shared/utils/resources/cache_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'vocabulary_event.dart';
part 'vocabulary_state.dart';

class VocabularyBloc extends Bloc<VocabularyEvent, VocabularyState> {
  final FirebaseFirestore firestore = locator<FirebaseFirestore>();
  VocabularyBloc() : super(VocabularyInitial()) {
    on<FetchVocabulary>(_fetchVocabulary);
  }

  FutureOr<void> _fetchVocabulary(
      FetchVocabulary event, Emitter<VocabularyState> emit) async {
    emit(VocabularyLoading());
    try {
      var cacheKey = 'words_${event.categoryId}';
      var cachedWords = CacheManager().retrieve(cacheKey);
      // var cachedVocabularies = CacheManager().retrieve('vocabularies');
      if (cachedWords != null) {
        print('worddddd ${cachedWords[0]}');
        emit(VocabularyLoaded(cachedWords));
      } else {
        var snapshot = await firestore
            .collection('vocabulary_categories')
            .doc(event.categoryId)
            .collection('vocabularies')
            .get();
        var words = snapshot.docs
            .map((doc) => VocabularyWord.fromFirestore(doc.data()))
            .toList();
        print('worddddd ${words[0]}');
        CacheManager().store(cacheKey, words);
        emit(VocabularyLoaded(words));
      }
    } catch (e) {
      emit(VocabularyError(e.toString()));
    }
  }
}
