part of 'register_bloc.dart';

@immutable
sealed class RegisterState {
  final bool isLoading;
  final AuthError? authError;

  const RegisterState({required this.isLoading, this.authError});
}

@immutable
sealed class RegisterActionState extends RegisterState {
  const RegisterActionState({required super.isLoading, AuthError? authError});
}

@immutable
class RegisterLoadingState extends RegisterActionState {
  const RegisterLoadingState({required super.isLoading});
}

class RegisterSuccessState extends RegisterActionState {
  const RegisterSuccessState({required super.isLoading});
}

@immutable
class RegisterErrorState extends RegisterActionState {
  const RegisterErrorState({
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
      'RegisterErrorState, isLoading = $isLoading, authError = $authError';
}

@immutable
class NavigateToLoginScreenState extends RegisterActionState {
  const NavigateToLoginScreenState({required super.isLoading});
}
