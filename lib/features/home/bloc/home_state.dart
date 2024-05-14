// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final Topics topics;
  final List<LessonProgress> progress;

  HomeLoaded({
    required this.topics,
    required this.progress,
  });
}

class HomeLoadError extends HomeState {
  final String message;

  HomeLoadError(this.message);
}
