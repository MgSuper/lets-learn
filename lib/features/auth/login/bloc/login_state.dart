part of 'login_bloc.dart';

@immutable
sealed class LoginState {
  final bool isLoading;
  final AuthError? authError;

  const LoginState({required this.isLoading, this.authError});
}

@immutable
sealed class LoginActionState extends LoginState {
  const LoginActionState({required super.isLoading, AuthError? authError});
}

@immutable
class LoginLoadingState extends LoginActionState {
  const LoginLoadingState({required super.isLoading});
}

class LoginSuccessState extends LoginActionState {
  const LoginSuccessState({required super.isLoading});
}

@immutable
class LoginErrorState extends LoginActionState {
  const LoginErrorState({
    required bool isLoading,
    AuthError? authError,
  }) : super(
          isLoading: isLoading,
          authError: authError,
        );
  // toString mainly used 2 purpose, if you're doing poor man debugging and print
  // AppAuthState to screen just to sure things done correctly in AppBloc, the other one is
  // this could be quite helpful when doing bloc test
  @override
  String toString() =>
      'LoginErrorState, isLoading = $isLoading, authError = $authError';
}

@immutable
class NavigateToRegisterScreenState extends LoginActionState {
  const NavigateToRegisterScreenState({required super.isLoading});
}
