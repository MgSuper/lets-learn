import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:boost_e_skills/core/models/lesson_progress.dart';
import 'package:boost_e_skills/core/models/topics_model.dart';
import 'package:boost_e_skills/features/home/repo/home_repository.dart';
import 'package:boost_e_skills/locator.dart';
import 'package:boost_e_skills/shared/utils/resources/cache_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepository = locator<HomeRepository>();
  final FirebaseFirestore firestore = locator<FirebaseFirestore>();
  HomeBloc() : super(HomeInitial()) {
    on<TabChanged>(_tabChanges);
    on<UpdateHomeState>(_updateHomeState);
  }

  FutureOr<void> _tabChanges(TabChanged event, Emitter<HomeState> emit) async {
    var cachedTopic = CacheManager().retrieve(event.topicName);
    var cachedProgress = CacheManager().retrieve('userProgress');
    if (cachedTopic != null && cachedProgress != null) {
      emit(HomeLoaded(
          topics: cachedTopic as Topics,
          progress: cachedProgress as List<LessonProgress>));
    } else {
      emit(HomeLoading()); // Optional: to show loading indicator
      // await Future.delayed(const Duration(days: 1));
      // final currentTopic =
      //     state is HomeLoaded ? (state as HomeLoaded).topics : null;
      // if (event.topicName == currentTopic) return; // Prevent redundant updates
      try {
        Topics topic =
            await _homeRepository.fetchUpdatedTopics(event.topicName);
        List<LessonProgress> userProgress = await _homeRepository
            .fetchUserProgress(FirebaseAuth.instance.currentUser!.uid);
        CacheManager().store(event.topicName, topic);
        CacheManager().store('userProgress', userProgress);
        emit(HomeLoaded(topics: topic, progress: userProgress));
      } catch (e) {
        emit(HomeLoadError('Failed to load data: ${e.toString()}'));
      }
    }
  }

  FutureOr<void> _updateHomeState(
      UpdateHomeState event, Emitter<HomeState> emit) async {
    try {
      Topics updatedTopic =
          await _homeRepository.fetchUpdatedTopics(event.topicName);
      List<LessonProgress> userProgress = await _homeRepository
          .fetchUserProgress(FirebaseAuth.instance.currentUser!.uid);
      // Store the updated information
      CacheManager().store(event.topicName, updatedTopic);
      CacheManager().store('userProgress', userProgress);
      emit(HomeLoaded(topics: updatedTopic, progress: userProgress));
    } catch (e) {
      emit(HomeLoadError('Failed to update home state: ${e.toString()}'));
    }
  }
}
