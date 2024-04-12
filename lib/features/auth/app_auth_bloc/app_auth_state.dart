// ignore_for_file: public_member_api_docs, sort_constructors_first
// step_3
// we're only going to have like one AppAuthState as the general like umbrella kind of
// state however it is also important to go ahead and define the various states of
// the application with their own concrete implementation, so we're going to have
// one AppAuthState that has a few base properties such as isLoading or any authentication
// errors but we're also go ahead and define AppAuthState for instance for when you're
// logout or when you're in the registration view or when you're try to login. It
// means various screens are going to have their own AppAuthStates ( concrete implementations
// of this abstract class )
part of 'app_auth_bloc.dart';

@immutable
sealed class AppAuthState {
  // any app states in our application can have this particular property for instance
  // isLoading
  // generic AppAuthState( with generic properties ( overall AppAuthState the super class ) )
  final bool isLoading;
  // later that two other subclasses are going to have the possibility of having
  // an AuthError emitted in them.
  final AuthError? authError;

  const AppAuthState({
    required this.isLoading,
    this.authError,
  });
}

@immutable
// it's not implementing AppAuthState which means that it actually going to use the
// properties of AppAuthState without re-implementing those properties
class AppAuthStateLoggedIn extends AppAuthState {
  // not same with Vandad
  final User user;
  const AppAuthStateLoggedIn({
    required bool isLoading,
    required this.user,
    AuthError? authError,
  }) : super(
          isLoading: isLoading,
          authError: authError,
        );
}

@immutable
class AppAuthStateLoggedOut extends AppAuthState {
  const AppAuthStateLoggedOut({
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
      'AppAuthStateLoggedOut, isLoading = $isLoading, authError = $authError';
}

@immutable
class AppAuthStateCheck extends AppAuthState {
  const AppAuthStateCheck({
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
      'AppAuthStateLoggedOut, isLoading = $isLoading, authError = $authError';
}

// this class really just a statement that telling our bloc that you can end up
// being in a stituation where you have to be in a registration view and that why
// we have this particular AppAuthState
@immutable
class AppAuthStateIsRegistrationView extends AppAuthState {
  const AppAuthStateIsRegistrationView({
    required bool isLoading,
    AuthError? authError,
  }) : super(
          isLoading: isLoading,
          authError: authError,
        );
}

@immutable
class AppAuthStateGoToSelectCategory extends AppAuthState {
  const AppAuthStateGoToSelectCategory({
    required bool isLoading,
    AuthError? authError,
  }) : super(
          isLoading: isLoading,
          authError: authError,
        );
}

@immutable
class AppAuthStateRegistered extends AppAuthState {
  const AppAuthStateRegistered({
    required bool isLoading,
    AuthError? authError,
  }) : super(
          isLoading: isLoading,
          authError: authError,
        );
}
