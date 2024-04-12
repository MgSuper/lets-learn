part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class ClickedLoginButtonEvent extends LoginEvent {
  final String userName;
  final String password;

  ClickedLoginButtonEvent({required this.userName, required this.password});
}

class ClickedToNavigateRegisterEvent extends LoginEvent {}
