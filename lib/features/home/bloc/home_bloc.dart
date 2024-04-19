import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:boost_e_skills/features/home/models/topics_model.dart';
import 'package:boost_e_skills/features/home/models/vocab_model.dart';
import 'package:boost_e_skills/locator.dart';
import 'package:boost_e_skills/shared/utils/resources/cache_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FirebaseFirestore firestore = locator<FirebaseFirestore>();
  final Map<String, Topics> _cachedTopics = {};
  StreamSubscription? _topicSubscription;
  StreamSubscription? _vocabSubscription;
  HomeBloc() : super(HomeInitial()) {
    on<TabChanged>(_tabChanges);
  }

  @override
  Future<void> close() {
    _topicSubscription?.cancel();
    _vocabSubscription?.cancel();
    return super.close();
  }

  FutureOr<void> _tabChanges(TabChanged event, Emitter<HomeState> emit) async {
    var cached = CacheManager().retrieve(event.topicName);
    if (cached != null) {
      if (event.topicName == 'grammar' || event.topicName == 'idioms') {
        emit(HomeLoaded(topics: cached));
      } else {
        emit(VocabCategoryLoaded(cached));
      }
    } else {
      emit(HomeLoading()); // Optional: to show loading indicator
      await Future.delayed(
        const Duration(
          milliseconds: 1000,
        ),
      );
      final currentTopic =
          state is HomeLoaded ? (state as HomeLoaded).topics : null;
      if (event.topicName == currentTopic) return; // Prevent redundant updates
      try {
        if (event.topicName == 'grammar' || event.topicName == 'idioms') {
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
          CacheManager().store(event.topicName, topic);
          emit(HomeLoaded(topics: topic));
        } else {
          var cachedCategories = CacheManager().retrieve('categories');
          if (cachedCategories != null) {
            emit(VocabCategoryLoaded(cachedCategories));
          } else {
            var snapshot =
                await firestore.collection('vocabulary_categories').get();
            var categories = snapshot.docs
                .map((doc) => VocabCategory.fromFirestore(doc.data(), doc.id))
                .toList();
            CacheManager().store(event.topicName, categories);
            emit(VocabCategoryLoaded(categories));
          }
        }
      } catch (e) {
        emit(HomeLoadError('Failed to load data: ${e.toString()}'));
      }
      // if (event.topicName == 'grammar' || event.topicName == 'idioms') {
      //   print('event.topicName is is is ${event.topicName}');
      //   _topicSubscription?.cancel();
      //   _topicSubscription = firestore
      //       .collection('topics')
      //       .doc(event.topicName)
      //       .snapshots()
      //       .listen((topicSnapshot) async {
      //     if (!topicSnapshot.exists) {
      //       emit(HomeLoadError('No topic found for ${event.topicName}'));
      //       return;
      //     }

      //     var topic = Topics.fromSnapshot(topicSnapshot);

      //     try {
      //       // Fetch basic lessons once and set up a separate listener if real-time updates are needed
      //       var lessonsSnapshot = await firestore
      //           .collection('topics')
      //           .doc(event.topicName)
      //           .collection('basic_lessons')
      //           .get();

      //       List<BasicLesson> basicLessons = lessonsSnapshot.docs
      //           .map((doc) => BasicLesson.fromSnapshot(doc))
      //           .toList();

      //       topic.basicLesson = basicLessons;

      //       // Cache and emit loaded topic
      //       _cachedTopics[event.topicName] = topic;
      //       CacheManager().store(event.topicName, topic);

      //       print('Hereeeeee I am ${topic.topic}');
      //       print('emit.isDone ${emit.isDone}');
      //       if (emit.isDone) {
      //         print('emit ${emit.isDone}');
      //         emit(HomeLoaded(topics: topic));
      //       }
      //     } catch (e) {
      //       if (!emit.isDone) {
      //         emit(HomeLoadError(
      //             'Failed to load basic lessons: ${e.toString()}'));
      //       }
      //     }
      //   }, onError: (error) {
      //     if (!emit.isDone) {
      //       emit(HomeLoadError(
      //           'Failed to load topic data: ${error.toString()}'));
      //     }
      //   });
      // } else {
      //   _vocabSubscription?.cancel();
      //   List<VocabCategory>? cachedCategories =
      //       CacheManager().retrieve('categories');
      //   if (cachedCategories != null) {
      //     emit(VocabCategoryLoaded(cachedCategories));
      //   } else {
      //     _vocabSubscription = firestore
      //         .collection('vocabulary_categories')
      //         .snapshots()
      //         .listen((snapshot) {
      //       List<VocabCategory> categories = snapshot.docs
      //           .map((doc) => VocabCategory.fromFirestore(doc.data(), doc.id))
      //           .toList();
      //       CacheManager().store('categories', categories);

      //       // Check if it's still valid to emit
      //       if (!emit.isDone) {
      //         emit(VocabCategoryLoaded(categories));
      //       }
      //     }, onError: (error) {
      //       // Also check if it's still valid to emit in case of error
      //       if (!emit.isDone) {
      //         emit(HomeLoadError('Failed to load data: ${error.toString()}'));
      //       }
      //     });
      //   }
      // }
    }
  }
}
