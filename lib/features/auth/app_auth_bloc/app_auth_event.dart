// step_2
// we are going to have an abstract class called AppAuthEvent and all our events
// inside this application are going to be of the type AppAuthEvent but the AppAuthEvent
// class itself is just going to be an abstract class which is not constructable
part of 'app_auth_bloc.dart';

@immutable
sealed class AppAuthEvent {
  // this is the overall AppAuthEvent, any AppAuthEvent inside our application that's going
  // to be sent to the AppBloc is going to be this type AppAuthEvent
  const AppAuthEvent();
}

// Events are literally just signals that you send to your AppBloc
// Events usually are immutable classes with const constructor so because
// they don't have any type of logic, they shouldn't be mutating like if you
// create an AppAuthEvent and send it to your Bloc, your Bloc shouldn't be able to
// mutate that event. Very important to keep it immutable because you don't want
// side effects happening from where the ui dispatches an event to where the
// Bloc is processing that event

@immutable
class AppAuthEventLogOut implements AppAuthEvent {
  const AppAuthEventLogOut();
}

@immutable
class AppAuthEventInitialize implements AppAuthEvent {
  const AppAuthEventInitialize();
}

@immutable
class AppAuthEventLogIn implements AppAuthEvent {
  final String userName;
  final String password;

  const AppAuthEventLogIn({
    required this.userName,
    required this.password,
  });
}

@immutable
class AppAuthEventRegister implements AppAuthEvent {
  final String userName;
  final String password;

  const AppAuthEventRegister({
    required this.userName,
    required this.password,
  });
}

@immutable
class AppAuthEventGoToRegistration implements AppAuthEvent {
  const AppAuthEventGoToRegistration();
}

@immutable
class AppAuthEventGoToSelectCategory implements AppAuthEvent {
  const AppAuthEventGoToSelectCategory();
}

@immutable
class AppAuthEventGoToLogIn implements AppAuthEvent {
  const AppAuthEventGoToLogIn();
}
