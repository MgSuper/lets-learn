part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

@immutable
class FetchUserDataEvent extends SettingsEvent {}

@immutable
class LogoutEvent extends SettingsEvent {}
