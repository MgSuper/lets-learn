import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:boost_e_skills/core/models/lesson_progress.dart';
import 'package:boost_e_skills/core/models/vocab_model.dart';
import 'package:boost_e_skills/locator.dart';
import 'package:boost_e_skills/shared/utils/resources/cache_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'vocab_category_event.dart';
part 'vocab_category_state.dart';

class VocabCategoryBloc extends Bloc<VocabCategoryEvent, VocabCategoryState> {
  final FirebaseFirestore firestore = locator<FirebaseFirestore>();
  VocabCategoryBloc() : super(VocabCategoryInitial()) {
    on<FetchVocabCategories>(_fetchVocabCategories);
  }

  FutureOr<void> _fetchVocabCategories(
      FetchVocabCategories event, Emitter<VocabCategoryState> emit) async {
    emit(VocabCategoryLoading());
    try {
      List<VocabCategory>? cachedCategories =
          CacheManager().retrieve('categories');
      if (cachedCategories != null) {
        emit(VocabCategoryLoaded(cachedCategories));
      } else {
        var snapshot = await firestore
            .collection('vocabulary_categories')
            .orderBy('timestamp', descending: true)
            .get();
        List<VocabCategory> categories = snapshot.docs
            .map((doc) => VocabCategory.fromFirestore(doc.data(), doc.id))
            .toList();
        CacheManager().store('vocabulary', categories);
        emit(VocabCategoryLoaded(categories));
      }
    } catch (e) {
      emit(VocabCategoryError(e.toString()));
    }
  }
}
