part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

@immutable
class ClickedRegisterButtonEvent extends RegisterEvent {
  final String userName;
  final String password;

  ClickedRegisterButtonEvent({required this.userName, required this.password});
}

@immutable
class ClickedToNavigateLoginEvent extends RegisterEvent {}
