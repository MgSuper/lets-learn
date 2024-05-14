// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:boost_e_skills/core/models/topics_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:boost_e_skills/features/home/bloc/home_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'grammar_event.dart';
part 'grammar_state.dart';

class GrammarBloc extends Bloc<GrammarEvent, GrammarState> {
  final FirebaseFirestore firestore;
  final HomeBloc homeBloc;
  GrammarBloc({
    required this.firestore,
    required this.homeBloc,
  }) : super(GrammarInitial()) {
    on<LoadGrammar>(_loadGrammar);
    on<MarkLessonAsLearned>(_markLessonAsLearned);
  }

  FutureOr<void> _markLessonAsLearned(
      MarkLessonAsLearned event, Emitter<GrammarState> emit) async {
    try {
      await FirebaseFirestore.instance
          .collection('user_progress')
          .doc('${event.userId}_${event.lessonId}')
          .set({
        'userId': event.userId,
        'lessonId': event.lessonId,
        'isLearned': true,
        'learnedOn': FieldValue.serverTimestamp(),
      });

      // Communicate success to HomeBloc

      homeBloc.add(UpdateHomeState(event.lessonId, event.topicName));
      if (state is GrammarLoaded) {
        var currentState = state as GrammarLoaded;
        emit(GrammarLoaded(lesson: currentState.lesson, isLearned: true));
      }
    } catch (e) {
      emit(GrammarLearnError(e.toString()));
    }
  }

  FutureOr<void> _loadGrammar(
      LoadGrammar event, Emitter<GrammarState> emit) async {
    emit(GrammarLearnLoading());
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await firestore
          .collection('topics')
          .doc(event.topic)
          .collection('basic_lessons')
          .doc(event.lessonId)
          .get();
      if (!doc.exists) {
        emit(const GrammarLearnError("Lesson not found"));
        return;
      }
      BasicLesson lesson = BasicLesson.fromSnapshot(doc);
      // Assuming there is a way to check if the lesson has been learned
      bool isLearned = await checkIfLessonIsLearned(
          FirebaseAuth.instance.currentUser!.uid, lesson.id);
      emit(GrammarLoaded(lesson: lesson, isLearned: isLearned));
    } catch (e) {
      emit(GrammarLearnError(e.toString()));
    }
  }

  Future<bool> checkIfLessonIsLearned(String userId, String lessonId) async {
    // Implement your method to check if the lesson is learned
    var snapshot = await firestore
        .collection('user_progress')
        .where('userId', isEqualTo: userId)
        .where('lessonId', isEqualTo: lessonId)
        .get();
    return snapshot.docs.isNotEmpty;
  }
}
