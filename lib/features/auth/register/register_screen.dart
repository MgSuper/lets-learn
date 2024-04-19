import 'package:boost_e_skills/features/auth/register/bloc/register_bloc.dart';
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

class RegisterScreen extends HookWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterBloc registerBloc = RegisterBloc();
    final nameController = useTextEditingController(
        // text: 'super.dev1001@gmail.com'.ifDebugging,
        );
    final passwordController = useTextEditingController(
        // text: 'foobarbaz'.ifDebugging,
        );
    final registerFormKey = GlobalKey<FormState>();

    useEffect(() {
      // Initialization code or side effects go here.

      return () {
        // This function will be called when the widget is disposed.
        registerBloc.close();
      };
    }, [registerBloc]);
    return BlocConsumer<RegisterBloc, RegisterState>(
      bloc: registerBloc,
      listenWhen: (previous, current) => current is RegisterActionState,
      listener: (context, state) {
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
        if (state is NavigateToLoginScreenState) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/login', (Route<dynamic> route) => false);
        }
        if (state is RegisterSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Successfully registered! Please Login.'),
            ),
          );
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/login', (Route<dynamic> route) => false);
        }
      },
      buildWhen: (previous, current) => current is! RegisterActionState,
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    AppString.register,
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
                      inputType: TextInputType.text,
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
                    ),
                    const SizedBox(height: AppSize.s36),
                    TextButton(
                      onPressed: () async {
                        if (registerFormKey.currentState!.validate()) {
                          registerBloc.add(
                            ClickedRegisterButtonEvent(
                              userName: nameController.text,
                              password: passwordController.text,
                            ),
                          );
                        }
                      },
                      child: Text(
                        AppString.register,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(decoration: TextDecoration.underline),
                      ),
                    ),
                    const SizedBox(height: AppSize.s60),
                    Text(
                      AppString.alreadyAccount,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: ColorManager.white,
                            fontSize: AppSize.s14,
                          ),
                    ),
                    const SizedBox(height: AppSize.s8),
                    TextButton(
                      onPressed: () {
                        registerBloc.add(ClickedToNavigateLoginEvent());
                      },
                      child: Text(
                        AppString.loginHere,
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
        );
      },
    );
  }
}
