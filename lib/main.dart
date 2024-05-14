import 'package:boost_e_skills/bloc/theme_cubit.dart';
import 'package:boost_e_skills/features/auth/authentication_bloc/authentication_bloc.dart';
import 'package:boost_e_skills/features/auth/login/bloc/login_bloc.dart';
import 'package:boost_e_skills/features/auth/login/login_screen.dart';
import 'package:boost_e_skills/features/auth/register/bloc/register_bloc.dart';
import 'package:boost_e_skills/features/auth/register/register_screen.dart';
import 'package:boost_e_skills/features/home/bloc/home_bloc.dart';
import 'package:boost_e_skills/features/knowledge_content/bloc/knowledge_content_bloc.dart';
import 'package:boost_e_skills/features/learn_grammar/bloc/grammar_bloc.dart';
import 'package:boost_e_skills/features/learn_vocabulary/blocs/vocab_category/vocab_category_bloc.dart';
import 'package:boost_e_skills/features/learn_vocabulary/blocs/vocabularies/vocabularies_bloc.dart';
import 'package:boost_e_skills/features/learn_vocabulary/blocs/vocabulary/vocabulary_bloc.dart';
import 'package:boost_e_skills/features/main/bloc/main_screen_bloc.dart';
import 'package:boost_e_skills/features/main/main_screen.dart';
import 'package:boost_e_skills/features/portfolio/portfolio_screen.dart';
import 'package:boost_e_skills/features/settings/bloc/settings_bloc.dart';
import 'package:boost_e_skills/features/welcome/bloc/welcome_bloc.dart';
import 'package:boost_e_skills/firebase_options.dart';
import 'package:boost_e_skills/locator.dart';
import 'package:boost_e_skills/routes.dart';
import 'package:boost_e_skills/shared/utils/resources/theme_manager.dart';
import 'package:boost_e_skills/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDependencies();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (_) => locator<LoginBloc>()),
        BlocProvider<RegisterBloc>(create: (_) => locator<RegisterBloc>()),
        BlocProvider<AuthenticationBloc>(
          create: (_) => locator<AuthenticationBloc>()
            ..add(
              AuthenticationEvent.appStarted,
            ),
        ),
        BlocProvider<MainScreenBloc>(create: (_) => locator<MainScreenBloc>()),
        BlocProvider<HomeBloc>(create: (_) => locator<HomeBloc>()),
        BlocProvider<GrammarBloc>(create: (_) => locator<GrammarBloc>()),
        BlocProvider<VocabCategoryBloc>(
            create: (_) => locator<VocabCategoryBloc>()),
        BlocProvider<VocabularyBloc>(create: (_) => locator<VocabularyBloc>()),
        BlocProvider<VocabulariesBloc>(
            create: (_) => locator<VocabulariesBloc>()),
        BlocProvider<ThemeCubit>(
          create: (_) => locator<ThemeCubit>(),
        ),
        BlocProvider<WelcomeBloc>(
          create: (_) => locator<WelcomeBloc>()..add(CheckWelcomeStatus()),
        ),
        BlocProvider<SettingsBloc>(
          create: (_) => locator<SettingsBloc>(),
        ),
        BlocProvider<KnowledgeContentBloc>(
          create: (_) => locator<KnowledgeContentBloc>()
            ..add(const FetchKnowledgeContents()),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: getApplicationTheme(),
            showPerformanceOverlay: false,
            builder: EasyLoading.init(),
            initialRoute: '/',
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case Routes.splash:
                  return MaterialPageRoute(
                      builder: (context) => const SplashScreen());
                case Routes.login:
                  return MaterialPageRoute(
                      builder: (context) => const LoginScreen());
                case Routes.register:
                  return MaterialPageRoute(
                      builder: (context) => const RegisterScreen());
                case Routes.main:
                  return MaterialPageRoute(
                      builder: (context) => const MainScreen());
                case Routes.portfolio:
                  return MaterialPageRoute(
                      builder: (context) => const PortfolioScreen());
                default:
                  // Define a route for handling unknown routes.
                  return MaterialPageRoute(builder: (context) => Container());
              }
            },
          );
        },
      ),
    );
  }
}
