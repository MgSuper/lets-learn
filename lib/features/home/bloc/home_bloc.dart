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
  Map<String, Topics> _cachedTopics = {};
  HomeBloc() : super(HomeInitial()) {
    on<LoadTopic>(_loadTopic);
    on<RefreshTopic>(_refreshTopic);
    // on<TabChanged>(_tabChanged);
  }

  FutureOr<void> _loadTopic(LoadTopic event, Emitter<HomeState> emit) async {
    if (_cachedTopics.containsKey(event.topicName)) {
      emit(HomeLoaded(_cachedTopics[event.topicName]!));
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
        emit(HomeLoaded(topic));
      } catch (e) {
        emit(HomeLoadError(e.toString()));
      }
    }
  }

  FutureOr<void> _refreshTopic(
      RefreshTopic event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      // Fetch the main topic document
      DocumentSnapshot<Map<String, dynamic>> topicSnapshot =
          await firestore.collection('topics').doc(event.topicName).get();
      Topics topic = Topics.fromSnapshot(topicSnapshot);

      // Fetch the basic lessons from the subcollection
      var lessonsSnapshot = await firestore
          .collection('topics')
          .doc(event.topicName)
          .collection('lessons')
          .get();
      var basicLessons = lessonsSnapshot.docs
          .map((doc) => BasicLesson.fromSnapshot(doc))
          .toList();

      // Update the topic object with the fetched lessons
      topic.basicLesson = basicLessons;

      // Update cache
      _cachedTopics[event.topicName] = topic;

      // Emit the loaded state with the refreshed data
      emit(HomeLoaded(topic));
    } catch (e) {
      emit(HomeLoadError(e.toString()));
    }
  }

  // FutureOr<void> _tabChanged(TabChanged event, Emitter<HomeState> emit) async {
  //   // Assuming you have a method to fetch data based on the topic
  // try {
  //   final data = await _fetchDataForTopic(event.topic);
  //   emit(HomeLoaded(data));
  // } catch (error) {
  //   emit(HomeLoadError(error.toString()));
  // }
  // }
}
