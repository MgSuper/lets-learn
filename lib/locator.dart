import 'package:boost_e_skills/bloc/theme_cubit.dart';
import 'package:boost_e_skills/features/auth/app_auth_bloc/app_auth_bloc.dart';
import 'package:boost_e_skills/features/auth/auth_repo/auth_repo.dart';
import 'package:boost_e_skills/features/auth/authentication_bloc/authentication_bloc.dart';
import 'package:boost_e_skills/features/auth/login/bloc/login_bloc.dart';
import 'package:boost_e_skills/features/auth/login/repo/login_repo.dart';
import 'package:boost_e_skills/features/auth/register/bloc/register_bloc.dart';
import 'package:boost_e_skills/features/home/bloc/home_bloc.dart';
import 'package:boost_e_skills/features/main/bloc/main_screen_bloc.dart';
import 'package:boost_e_skills/features/settings/bloc/settings_bloc.dart';
import 'package:boost_e_skills/features/settings/repo/user_repo.dart';
import 'package:boost_e_skills/features/welcome/bloc/welcome_bloc.dart';
import 'package:boost_e_skills/features/welcome/repo/welcome_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt locator = GetIt.instance;

void initializeDependencies() {
  locator.registerSingletonAsync<SharedPreferences>(() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  });
  locator.registerLazySingleton(() => ThemeCubit());

  locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  locator.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);

  locator.registerLazySingleton<LoginBloc>(
    () => LoginBloc(),
  );

  locator.registerLazySingleton<RegisterBloc>(
    () => RegisterBloc(),
  );

  locator.registerLazySingleton<AuthenticationBloc>(
    () => AuthenticationBloc(),
  );

  locator.registerLazySingleton<MainScreenBloc>(
    () => MainScreenBloc(),
  );

  locator.registerLazySingleton<HomeBloc>(
    () => HomeBloc(),
  );

  locator.registerLazySingleton<UserRepository>(() => UserRepository());

  locator.registerLazySingleton<SettingsBloc>(
    () => SettingsBloc(userRepository: locator<UserRepository>()),
  );

  locator
      .registerFactory(() => AuthRepo(firebaseAuth: locator<FirebaseAuth>()));

  locator
      .registerFactory(() => LoginRepo(firebaseAuth: locator<FirebaseAuth>()));

  locator.registerLazySingleton<AppAuthBloc>(
      () => AppAuthBloc(authRepo: locator<AuthRepo>()));

  locator.registerFactory(
      () => WelcomeRepo(sharedPreferences: locator<SharedPreferences>()));
  locator
      .registerFactory(() => WelcomeBloc(repository: locator<WelcomeRepo>()));
}
