part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class LoadTopic extends HomeEvent {
  final String topicName;

  LoadTopic(this.topicName);
}

// class TabChanged extends HomeEvent {
//   final String topic;
//   TabChanged(this.topic);
// }

class RefreshTopic extends HomeEvent {
  final String topicName;

  RefreshTopic(this.topicName);
}
