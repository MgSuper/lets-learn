part of 'vocabulary_bloc.dart';

sealed class VocabularyEvent extends Equatable {
  const VocabularyEvent();

  @override
  List<Object> get props => [];
}

class FetchVocabulary extends VocabularyEvent {
  final String categoryId;
  const FetchVocabulary(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}
