import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  MainScreenBloc() : super(NavTabChangeState(selectedIndex: 0)) {
    on<NavigationTabChanged>(_navigationTabChanged);
  }

  FutureOr<void> _navigationTabChanged(
      NavigationTabChanged event, Emitter<MainScreenState> emit) {
    emit(NavTabChangeState(selectedIndex: event.tabIndex));
  }
}
