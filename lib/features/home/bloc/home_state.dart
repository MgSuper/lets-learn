// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final Topics topics;

  HomeLoaded({
    required this.topics,
  });
}

class VocabCategoryLoaded extends HomeState {
  final List<VocabCategory> categories;
  VocabCategoryLoaded(this.categories);
}

class HomeLoadError extends HomeState {
  final String message;

  HomeLoadError(this.message);
}
