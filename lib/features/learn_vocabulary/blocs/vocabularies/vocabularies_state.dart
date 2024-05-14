part of 'vocabularies_bloc.dart';

sealed class VocabulariesState extends Equatable {
  const VocabulariesState();

  @override
  List<Object> get props => [];
}

final class VocabulariesInitial extends VocabulariesState {}

class VocabulariesLoading extends VocabulariesState {}

class VocabulariesLoaded extends VocabulariesState {
  final List<VocabularyWord> words;
  final List<LessonProgress> progress;
  const VocabulariesLoaded({
    required this.words,
    required this.progress,
  });
  @override
  List<Object> get props => [words];
}

class VocabulariesError extends VocabulariesState {
  final String message;
  const VocabulariesError(this.message);
  @override
  List<Object> get props => [message];
}
