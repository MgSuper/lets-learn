import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:boost_e_skills/core/models/lesson_progress.dart';
import 'package:boost_e_skills/core/models/vocab_model.dart';
import 'package:boost_e_skills/features/learn_vocabulary/repo/vocabulary_repository.dart';
import 'package:boost_e_skills/locator.dart';
import 'package:boost_e_skills/shared/utils/resources/cache_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'vocabularies_event.dart';
part 'vocabularies_state.dart';

class VocabulariesBloc extends Bloc<VocabulariesEvent, VocabulariesState> {
  final FirebaseFirestore firestore = locator<FirebaseFirestore>();
  final VocabularyRepository _repository = locator<VocabularyRepository>();
  VocabulariesBloc() : super(VocabulariesInitial()) {
    on<FetchVocabularies>(_fetchVocabularies);
    on<FetchUpdatedVocabularies>(_fetchUpdatedVocabularies);
  }

  FutureOr<void> _fetchVocabularies(
      FetchVocabularies event, Emitter<VocabulariesState> emit) async {
    emit(VocabulariesLoading());
    try {
      var cacheKey = 'words_${event.categoryId}';
      var cachedWords = CacheManager().retrieve(cacheKey);
      var cachedVocabProgress = CacheManager().retrieve('userVocabProgress');
      if (cachedWords != null) {
        emit(VocabulariesLoaded(
            words: cachedWords, progress: cachedVocabProgress));
      } else {
        emit(VocabulariesLoading()); // Optional: to show loading indicator
        await Future.delayed(const Duration(seconds: 5));
        List<VocabularyWord> words =
            await _repository.fetchVocabularies(event.categoryId);
        User? currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser == null) {
          emit(const VocabulariesError("User not authenticated"));
          return;
        }
        List<LessonProgress> userProgress =
            await _repository.fetchUserProgress(currentUser.uid);
        CacheManager().store(cacheKey, words);
        CacheManager().store('userVocabProgress', userProgress);
        emit(VocabulariesLoaded(words: words, progress: userProgress));
      }
    } catch (e) {
      emit(VocabulariesError(e.toString()));
    }
  }

  FutureOr<void> _fetchUpdatedVocabularies(
      FetchUpdatedVocabularies event, Emitter<VocabulariesState> emit) async {
    try {
      var cacheKey = 'words_${event.categoryId}';
      List<VocabularyWord> words =
          await _repository.fetchVocabularies(event.categoryId);
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        emit(const VocabulariesError("User not authenticated"));
        return;
      }
      List<LessonProgress> userProgress =
          await _repository.fetchUserProgress(currentUser.uid);
      CacheManager().store(cacheKey, words);
      CacheManager().store('userVocabProgress', userProgress);
      emit(VocabulariesLoaded(words: words, progress: userProgress));
    } catch (e) {
      emit(VocabulariesError('Failed to update home state: ${e.toString()}'));
    }
  }
}
