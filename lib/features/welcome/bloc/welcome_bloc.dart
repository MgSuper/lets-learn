// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:boost_e_skills/features/welcome/repo/welcome_repo.dart';
import 'package:meta/meta.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  final WelcomeRepo repository;
  WelcomeBloc({required this.repository}) : super(WelcomeInitial()) {
    on<CheckWelcomeStatus>(_checkWelcomeStatus);
    on<CompleteWelcome>(_completeWelcome);
  }
  FutureOr<void> _checkWelcomeStatus(
      CheckWelcomeStatus event, Emitter<WelcomeState> emit) {
    final hasCompletedWelcome = repository.hasCompletedWelcome;
    emit(hasCompletedWelcome ? WelcomeCompleted() : WelcomeNotCompleted());
  }

  FutureOr<void> _completeWelcome(
      CompleteWelcome event, Emitter<WelcomeState> emit) async {
    await repository.completeWelcome();
    emit(WelcomeCompleted());
  }

  // Method to check if Welcome is completed
  Future<bool> isWelcomeCompleted() async {
    final state = this.state;
    if (state is WelcomeCompleted) {
      return true;
    } else if (state is WelcomeNotCompleted) {
      return false;
    } else {
      // If the bloc state is not yet determined, you may need to fetch it from the repository
      // For simplicity, we'll return false here. You may need to adjust this logic based on your requirements.
      return false;
    }
  }
}
