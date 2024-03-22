import 'package:boost_e_skills/bloc/theme_cubit.dart';
import 'package:boost_e_skills/config/app_theme.dart';
import 'package:boost_e_skills/features/welcome_screen/welcome_screen.dart';
import 'package:boost_e_skills/locator/locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  // initialized Hydrated bloc
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (_) => locator<ThemeCubit>(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, ThemeMode mode) {
          return MaterialApp(
            title: 'Flutter Demo',
            themeMode: mode,
            darkTheme: AppTheme.dark,
            theme: AppTheme.light,
            home: const WelcomeScreen(),
          );
        },
      ),
    );
  }
}
