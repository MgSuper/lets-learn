// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:boost_e_skills/core/models/vocab_model.dart';
import 'package:boost_e_skills/features/learn_vocabulary/blocs/vocabularies/vocabularies_bloc.dart';
import 'package:boost_e_skills/features/learn_vocabulary/repo/vocabulary_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:boost_e_skills/locator.dart';

part 'vocabulary_event.dart';
part 'vocabulary_state.dart';

class VocabularyBloc extends Bloc<VocabularyEvent, VocabularyState> {
  final FirebaseFirestore firestore = locator<FirebaseFirestore>();
  final VocabularyRepository _repository = locator<VocabularyRepository>();
  final VocabulariesBloc vocabBloc;
  VocabularyBloc(
    this.vocabBloc,
  ) : super(VocabularyInitial()) {
    on<FetchVocabulary>(_fetchVocabulary);
    on<MarkVocabAsLearned>(_markVocabAsLearned);
  }

  FutureOr<void> _fetchVocabulary(
      FetchVocabulary event, Emitter<VocabularyState> emit) async {
    emit(VocabularyLoading());
    try {
      VocabularyWord vocabLesson =
          await _repository.fetchVocabulary(event.categoryId, event.vocabId);
      bool isLearned = await _repository.checkIfLessonIsLearned(
          FirebaseAuth.instance.currentUser!.uid, vocabLesson.id);
      emit(VocabularyLoaded(lesson: vocabLesson, isLearned: isLearned));
    } catch (e) {
      emit(VocabularyError(e.toString()));
    }
  }

  FutureOr<void> _markVocabAsLearned(
      MarkVocabAsLearned event, Emitter<VocabularyState> emit) async {
    try {
      await _repository.markVocabAsLearned(event.userId, event.vocabId);
      vocabBloc.add(FetchUpdatedVocabularies(categoryId: event.categoryId));

      if (state is VocabularyLoaded) {
        var currentState = state as VocabularyLoaded;
        emit(VocabularyLoaded(lesson: currentState.lesson, isLearned: true));
      }
    } catch (e) {
      emit(VocabularyError(e.toString()));
    }
  }
}
