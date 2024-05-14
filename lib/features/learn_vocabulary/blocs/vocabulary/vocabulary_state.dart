// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'vocabulary_bloc.dart';

sealed class VocabularyState extends Equatable {
  const VocabularyState();

  @override
  List<Object> get props => [];
}

sealed class VocabularyActionState extends VocabularyState {
  const VocabularyActionState();

  @override
  List<Object> get props => [];
}

class VocabularyInitial extends VocabularyState {}

class VocabularyLoading extends VocabularyState {}

// class VocabulariesLoaded extends VocabularyState {
//   final List<VocabularyWord> words;
//   final List<LessonProgress> progress;
//   const VocabulariesLoaded({
//     required this.words,
//     required this.progress,
//   });
//   @override
//   List<Object> get props => [words];
// }

class VocabularyLoaded extends VocabularyState {
  final VocabularyWord lesson;
  final bool isLearned;

  const VocabularyLoaded({required this.lesson, this.isLearned = false});

  @override
  List<Object> get props => [lesson, isLearned];
}

class VocabularyError extends VocabularyState {
  final String message;
  const VocabularyError(this.message);
  @override
  List<Object> get props => [message];
}
