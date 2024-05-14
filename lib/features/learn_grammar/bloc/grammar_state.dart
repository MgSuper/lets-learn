part of 'grammar_bloc.dart';

sealed class GrammarState extends Equatable {
  const GrammarState();

  @override
  List<Object> get props => [];
}

sealed class ActionGrammarState extends GrammarState {
  const ActionGrammarState();

  @override
  List<Object> get props => [];
}

class GrammarInitial extends GrammarState {}

class GrammarLearnLoading extends GrammarState {}

class GrammarLoaded extends GrammarState {
  final BasicLesson lesson;
  final bool isLearned;

  const GrammarLoaded({required this.lesson, this.isLearned = false});

  @override
  List<Object> get props => [lesson, isLearned];
}

class GrammarLearnError extends GrammarState {
  final String error;

  const GrammarLearnError(this.error);

  @override
  List<Object> get props => [error];
}
