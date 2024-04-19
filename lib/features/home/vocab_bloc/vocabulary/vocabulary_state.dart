part of 'vocabulary_bloc.dart';

sealed class VocabularyState extends Equatable {
  const VocabularyState();

  @override
  List<Object> get props => [];
}

class VocabularyInitial extends VocabularyState {}

class VocabularyLoading extends VocabularyState {}

class VocabularyLoaded extends VocabularyState {
  final List<VocabularyWord> words;
  const VocabularyLoaded(this.words);
  @override
  List<Object> get props => [words];
}

class VocabularyError extends VocabularyState {
  final String message;
  const VocabularyError(this.message);
  @override
  List<Object> get props => [message];
}
