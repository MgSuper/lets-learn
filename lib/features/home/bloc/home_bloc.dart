import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:boost_e_skills/features/home/models/topics_model.dart';
import 'package:boost_e_skills/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FirebaseFirestore firestore = locator<FirebaseFirestore>();
  final Map<String, Topics> _cachedTopics = {};
  HomeBloc() : super(HomeInitial()) {
    on<TabChanged>(_tabChanges);
    // on<TabChanged>(_tabChanged);
  }

  FutureOr<void> _loadTopic(TabChanged event, Emitter<HomeState> emit) async {
    if (_cachedTopics.containsKey(event.topicName)) {
      print('topic Name ${event.topicName}');
      emit(HomeLoaded(topics: _cachedTopics[event.topicName]!));
    } else {
      emit(HomeLoading());
      try {
        // Assuming 'topicName' is the ID of the document for grammar/vocabulary/idioms
        DocumentSnapshot<Map<String, dynamic>> topicSnapshot =
            await firestore.collection('topics').doc(event.topicName).get();
        Topics topic = Topics.fromSnapshot(topicSnapshot);

        // Now fetch the basic lessons from the subcollection
        var lessonsSnapshot = await firestore
            .collection('topics')
            .doc(event.topicName)
            .collection('basic_lessons')
            .get();
        var basicLessons = lessonsSnapshot.docs
            .map((doc) => BasicLesson.fromSnapshot(doc))
            .toList();

        // Update the topic object with the fetched lessons
        topic.basicLesson = basicLessons;

        // Cache and emit the loaded state
        _cachedTopics[event.topicName] = topic;
        print('topic Name ${event.topicName}');
        emit(HomeLoaded(topics: topic));
      } catch (e) {
        emit(HomeLoadError(e.toString()));
      }
    }
  }

  FutureOr<void> _tabChanges(TabChanged event, Emitter<HomeState> emit) async {
    if (_cachedTopics.containsKey(event.topicName)) {
      emit(HomeLoaded(topics: _cachedTopics[event.topicName]!));
    } else {
      emit(HomeLoading()); // Optional: to show loading indicator
      final currentTopic =
          state is HomeLoaded ? (state as HomeLoaded).topics : null;
      if (event.topicName == currentTopic) return; // Prevent redundant updates
      try {
        DocumentSnapshot<Map<String, dynamic>> topicSnapshot =
            await firestore.collection('topics').doc(event.topicName).get();
        if (!topicSnapshot.exists) {
          emit(HomeLoadError('No topic found for ${event.topicName}'));
          return;
        }
        Topics topic = Topics.fromSnapshot(topicSnapshot);

        QuerySnapshot<Map<String, dynamic>> lessonsSnapshot = await firestore
            .collection('topics')
            .doc(event.topicName)
            .collection('basic_lessons')
            .get();
        List<BasicLesson> basicLessons = lessonsSnapshot.docs
            .map((doc) => BasicLesson.fromSnapshot(doc))
            .toList();

        topic.basicLesson = basicLessons;
        _cachedTopics[event.topicName] = topic;
        emit(HomeLoaded(topics: topic));
      } catch (e) {
        emit(HomeLoadError('Failed to load data: ${e.toString()}'));
      }
    }
  }
}
