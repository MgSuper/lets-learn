part of 'vocab_category_bloc.dart';

sealed class VocabCategoryState extends Equatable {
  const VocabCategoryState();

  @override
  List<Object> get props => [];
}

class VocabCategoryInitial extends VocabCategoryState {}

class VocabCategoryLoading extends VocabCategoryState {}

class VocabCategoryLoaded extends VocabCategoryState {
  final List<VocabCategory> categories;
  const VocabCategoryLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}

class VocabCategoryError extends VocabCategoryState {
  final String message;
  const VocabCategoryError(this.message);

  @override
  List<Object> get props => [message];
}

class UserProgressLoaded extends VocabCategoryState {
  final List<LessonProgress> progress;

  const UserProgressLoaded(this.progress);
}

class UserProgressLoadError extends VocabCategoryState {
  final String message;

  const UserProgressLoadError(this.message);
}
