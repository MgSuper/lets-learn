// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'vocabulary_bloc.dart';

sealed class VocabularyEvent extends Equatable {
  const VocabularyEvent();

  @override
  List<Object> get props => [];
}

class FetchVocabulary extends VocabularyEvent {
  final String vocabId;
  final String categoryId;
  const FetchVocabulary({required this.vocabId, required this.categoryId});

  @override
  List<Object> get props => [vocabId];
}

class MarkVocabAsLearned extends VocabularyEvent {
  final String userId;
  final String vocabId;
  final String categoryId;

  const MarkVocabAsLearned({
    required this.userId,
    required this.vocabId,
    required this.categoryId,
  });
}
