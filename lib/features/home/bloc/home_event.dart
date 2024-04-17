part of 'home_bloc.dart';

@immutable
sealed class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TabChanged extends HomeEvent {
  final String topicName;

  TabChanged(this.topicName);

  @override
  List<Object?> get props => [topicName];
}
