part of 'vocabularies_bloc.dart';

sealed class VocabulariesEvent extends Equatable {
  const VocabulariesEvent();

  @override
  List<Object> get props => [];
}

class FetchVocabularies extends VocabulariesEvent {
  final String categoryId;
  const FetchVocabularies({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}

class FetchUpdatedVocabularies extends VocabulariesEvent {
  final String categoryId;
  const FetchUpdatedVocabularies({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}
