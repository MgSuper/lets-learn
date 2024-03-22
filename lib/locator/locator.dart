import 'package:boost_e_skills/bloc/theme_cubit.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void initializeDependencies() {
  locator.registerLazySingleton(() => ThemeCubit());
}
