part of 'settings_bloc.dart';

@immutable
sealed class SettingsState {}

@immutable
sealed class SettingsActionState extends SettingsState {
  final bool isLoading;
  // later that two other subclasses are going to have the possibility of having
  // an AuthError emitted in them.
  final AuthError? authError;

  SettingsActionState({required this.isLoading, this.authError});
}

final class UserDataLoading extends SettingsState {}

final class UserDataLoaded extends SettingsState {
  final AppUserModel user;
  UserDataLoaded(this.user);
}

final class UserDataError extends SettingsState {
  final String message;
  UserDataError(this.message);
}

@immutable
class LogoutState extends SettingsActionState {
  LogoutState({
    required bool isLoading,
    AuthError? authError,
  }) : super(
          isLoading: isLoading,
          authError: authError,
        );
}
