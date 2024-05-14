// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'grammar_bloc.dart';

sealed class GrammarEvent extends Equatable {
  const GrammarEvent();

  @override
  List<Object> get props => [];
}

class LoadGrammar extends GrammarEvent {
  final String lessonId;
  final String topic;

  const LoadGrammar({
    required this.lessonId,
    required this.topic,
  });

  @override
  List<Object> get props => [lessonId];
}

class MarkLessonAsLearned extends GrammarEvent {
  final String userId;
  final String lessonId;
  final String topicName;

  const MarkLessonAsLearned({
    required this.userId,
    required this.lessonId,
    required this.topicName,
  });

  @override
  List<Object> get props => [userId, lessonId, topicName];
}
