import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:boost_e_skills/features/auth/auth_error/auth_error.dart';
import 'package:boost_e_skills/features/auth/model/app_user_model.dart';
import 'package:boost_e_skills/features/settings/repo/user_repo.dart';
import 'package:boost_e_skills/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final UserRepository userRepository;
  AppUserModel? _cachedUser;
  SettingsBloc({required this.userRepository}) : super(UserDataLoading()) {
    on<FetchUserDataEvent>(_fetchUserData);
    on<LogoutEvent>(_logoutEvent);
  }

  FutureOr<void> _fetchUserData(
      FetchUserDataEvent event, Emitter<SettingsState> emit) async {
    if (_cachedUser != null) {
      emit(UserDataLoaded(_cachedUser!));
    }
    emit(UserDataLoading());
    final userId = locator<FirebaseAuth>().currentUser?.uid;
    print('userID   $userId');
    if (userId == null) {
      emit(UserDataError("User is not logged in."));
      return;
    }
    try {
      final user =
          await userRepository.getUser(userId); // Replace with actual user ID
      emit(UserDataLoaded(user));
    } catch (e) {
      emit(UserDataError(e.toString()));
    }
  }

  FutureOr<void> _logoutEvent(
      LogoutEvent event, Emitter<SettingsState> emit) async {
    emit(LogoutState(isLoading: true));
    await userRepository.signOutUser();
    emit(LogoutState(isLoading: false));
  }
}
