import 'package:boost_e_skills/features/auth/login/bloc/login_bloc.dart';
import 'package:boost_e_skills/shared/utils/dialogs/show_auth_error.dart';
import 'package:boost_e_skills/shared/utils/loading/loading_screen.dart';
import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/strings_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/validators.dart';
import 'package:boost_e_skills/shared/utils/resources/value_manager.dart';
import 'package:boost_e_skills/shared/widgets/generic_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = LoginBloc();
    final nameController = useTextEditingController(
        // text: 'super.dev1001@gmail.com'.ifDebugging,
        );
    final passwordController = useTextEditingController(
        // text: 'foobarbaz'.ifDebugging,
        );
    final loginFormKey = GlobalKey<FormState>();
    useEffect(() {
      // Initialization code or side effects go here.

      return () {
        // This function will be called when the widget is disposed.
        loginBloc.close();
        // passwordController.dispose();
      };
    }, [loginBloc]);
    return BlocConsumer<LoginBloc, LoginState>(
      bloc: loginBloc,
      listenWhen: (previous, current) => current is LoginActionState,
      listener: (context, state) {
        print('login stateeee $state');
        if (state.isLoading) {
          LoadingScreen.instance().show(
            context: context,
            text: 'Loading ...',
          );
        } else {
          LoadingScreen.instance().hide();
        }
        final authError = state.authError;
        if (authError != null) {
          showAuthError(
            authError: authError,
            context: context,
          );
        }
        if (state is NavigateToRegisterScreenState) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/register', (Route<dynamic> route) => false);

          // Navigator.of(context).pushReplacementNamed('/register');
        }
        if (state is LoginSuccessState) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/main', (Route<dynamic> route) => false);
        }
      },
      buildWhen: (previous, current) => current is! LoginActionState,
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Form(
              key: loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      AppString.login,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s90,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GenericTextField(
                        controller: nameController,
                        hintText: AppString.userName,
                        icon: const Icon(Icons.person),
                        inputType: TextInputType.emailAddress,
                        validator: Validators.validateUserName,
                      ),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      GenericTextField(
                        controller: passwordController,
                        hintText: AppString.password,
                        icon: const Icon(Icons.key),
                        isPassword: true,
                        obscuringChar: '◉',
                        validator: Validators.validatePassword,
                        // (p0) {
                        //   if (p0!.isEmpty) {
                        //     return 'Password can\'t be empty';
                        //   } else if (p0.length < 6) {
                        //     return 'Password can\'t less than 8 words';
                        //   }
                        //   return null;
                        // },
                      ),
                      const SizedBox(height: AppSize.s36),
                      TextButton(
                        onPressed: () async {
                          if (loginFormKey.currentState!.validate()) {
                            loginBloc.add(
                              ClickedLoginButtonEvent(
                                  userName: nameController.text,
                                  password: passwordController.text),
                            );
                          }
                        },
                        child: Text(
                          AppString.login,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(decoration: TextDecoration.underline),
                        ),
                      ),
                      const SizedBox(height: AppSize.s60),
                      Text(
                        AppString.noAccount,
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: ColorManager.white,
                                  fontSize: AppSize.s14,
                                ),
                      ),
                      const SizedBox(height: AppSize.s8),
                      TextButton(
                        onPressed: () {
                          print('go reg');
                          loginBloc.add(ClickedToNavigateRegisterEvent());
                        },
                        child: Text(
                          AppString.registerHere,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
