part of 'main_screen_bloc.dart';

@immutable
sealed class MainScreenEvent {}

@immutable
class NavigationTabChanged extends MainScreenEvent {
  final int tabIndex;
  NavigationTabChanged({required this.tabIndex});
}
