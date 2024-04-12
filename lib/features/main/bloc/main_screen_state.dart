part of 'main_screen_bloc.dart';

@immutable
sealed class MainScreenState {}

@immutable
final class NavTabChangeState extends MainScreenState {
  final int selectedIndex;
  NavTabChangeState({required this.selectedIndex});
}
