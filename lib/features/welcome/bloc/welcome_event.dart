part of 'welcome_bloc.dart';

@immutable
sealed class WelcomeEvent {}

class CheckWelcomeStatus extends WelcomeEvent {}

class CompleteWelcome extends WelcomeEvent {}
