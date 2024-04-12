part of 'welcome_bloc.dart';

@immutable
sealed class WelcomeState {}

final class WelcomeInitial extends WelcomeState {}

class WelcomeCompleted extends WelcomeState {}

class WelcomeNotCompleted extends WelcomeState {}
