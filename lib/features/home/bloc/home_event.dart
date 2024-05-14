// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

@immutable
sealed class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TabChanged extends HomeEvent {
  final String topicName;

  TabChanged(
    this.topicName,
  );

  @override
  List<Object?> get props => [topicName];
}

class UpdateHomeState extends HomeEvent {
  final String topicName; // Additional parameters as needed
  final String lessonId;

  UpdateHomeState(this.lessonId, this.topicName);

  @override
  List<Object> get props => [lessonId, topicName];
}
