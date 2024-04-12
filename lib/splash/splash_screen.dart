import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:boost_e_skills/features/auth/authentication_bloc/authentication_bloc.dart';
import 'package:boost_e_skills/features/auth/login/login_screen.dart';
import 'package:boost_e_skills/features/main/main_screen.dart';
import 'package:boost_e_skills/features/select_category/select_category_screen.dart';
import 'package:boost_e_skills/features/welcome/bloc/welcome_bloc.dart';
import 'package:boost_e_skills/features/welcome/welcome_screen.dart';
import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: ColorManager.primary,
      splash: Lottie.asset(
        'assets/splash_animation/splash_animation.json',
        repeat: false,
      ),
      nextScreen:
          BlocBuilder<WelcomeBloc, WelcomeState>(builder: (context, state) {
        if (state is WelcomeCompleted) {
          return BlocBuilder<AuthenticationBloc, AuthenticationState>(
            // listener: (context, state) {
            //   if (state.isLoading) {
            //     LoadingScreen.instance().show(
            //       context: context,
            //       text: 'Loading ...',
            //     );
            //   } else {
            //     if (state is AppAuthStateRegistered) {
            //       LoadingScreen.instance().hide();
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         const SnackBar(
            //           content: Text(
            //             'Registeration success, you can log in now .. ',
            //           ),
            //         ),
            //       );
            //     } else {
            //       LoadingScreen.instance().hide();
            //     }
            //   }
            //   final authError = state.authError;
            //   if (authError != null) {
            //     showAuthError(
            //       authError: authError,
            //       context: context,
            //     );
            //   }
            // },
            builder: (context, state) {
              print('splash state $state');
              if (state == AuthenticationState.uninitialized) {
                return const CircularProgressIndicator.adaptive();
              } else if (state == AuthenticationState.unauthenticated) {
                return const LoginScreen();
              } else {
                return const MainScreen();
              }
              // if (state is AppAuthStateLoggedOut) {
              //   return const LoginScreen();
              // } else if (state is AppAuthStateLoggedIn) {
              //   return const LoginScreen();
              // } else if (state is AppAuthStateLoggedIn) {
              //   return const SelectCategoryScreen();
              // } else if (state is AppAuthStateIsRegistrationView) {
              //   return const RegisterScreen();
              // } else {
              //   return Container();
              // }
            },
          );
        } else {
          return const WelcomeScreen();
        }
      }),
      splashIconSize: 250,
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.leftToRight,
    );
  }
}
