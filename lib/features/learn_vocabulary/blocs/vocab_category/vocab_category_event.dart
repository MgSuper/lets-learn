part of 'vocab_category_bloc.dart';

sealed class VocabCategoryEvent extends Equatable {
  const VocabCategoryEvent();

  @override
  List<Object> get props => [];
}

class FetchVocabCategories extends VocabCategoryEvent {}
