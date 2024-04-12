// step_9
import 'package:boost_e_skills/features/auth/login/bloc/login_bloc.dart';
import 'package:boost_e_skills/features/auth/register/bloc/register_bloc.dart';
import 'package:boost_e_skills/locator.dart';
import 'package:boost_e_skills/shared/utils/dialogs/show_auth_error.dart';
import 'package:boost_e_skills/shared/utils/loading/loading_screen.dart';
import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/strings_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/value_manager.dart';
import 'package:boost_e_skills/shared/widgets/generic_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AuthScreenContent extends HookWidget {
  final String type;
  const AuthScreenContent({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = locator<LoginBloc>();
    final RegisterBloc registerBloc = locator<RegisterBloc>();
    final nameController = useTextEditingController(
        // text: 'super.dev1001@gmail.com'.ifDebugging,
        );
    final passwordController = useTextEditingController(
        // text: 'foobarbaz'.ifDebugging,
        );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: type == 'Login'
            ? BlocConsumer<LoginBloc, LoginState>(
                listenWhen: (previous, current) => current is LoginActionState,
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
                  if (state is NavigateToRegisterScreenState) {
                    Navigator.of(context).pushReplacementNamed('/register');
                  }
                },
                buildWhen: (previous, current) => current is! LoginActionState,
                builder: (context, state) {
                  return Column(
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
                          ),
                          const SizedBox(height: AppSize.s36),
                          TextButton(
                            onPressed: () async {
                              loginBloc.add(
                                ClickedLoginButtonEvent(
                                    userName: nameController.text,
                                    password: passwordController.text),
                              );
                            },
                            child: Text(
                              AppString.login,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      decoration: TextDecoration.underline),
                            ),
                          ),
                          const SizedBox(height: AppSize.s60),
                          Text(
                            AppString.noAccount,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: ColorManager.white,
                                  fontSize: AppSize.s14,
                                ),
                          ),
                          const SizedBox(height: AppSize.s8),
                          TextButton(
                            onPressed: () {
                              loginBloc.add(ClickedToNavigateRegisterEvent());
                            },
                            child: Text(
                              AppString.registerHere,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                })
            : BlocConsumer<RegisterBloc, RegisterState>(
                listenWhen: (previous, current) =>
                    current is RegisterActionState,
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
                    Navigator.of(context).pushReplacementNamed('/login');
                  }
                },
                buildWhen: (previous, current) =>
                    current is! RegisterActionState,
                builder: (context, state) {
                  return Column(
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
                            inputType: TextInputType.emailAddress,
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
                          ),
                          const SizedBox(height: AppSize.s36),
                          TextButton(
                            onPressed: () async {
                              registerBloc.add(
                                ClickedRegisterButtonEvent(
                                  userName: nameController.text,
                                  password: passwordController.text,
                                ),
                              );
                              // appAuthBloc.add(const AppAuthEventLogOut());
                            },
                            child: Text(
                              AppString.register,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      decoration: TextDecoration.underline),
                            ),
                          ),
                          const SizedBox(height: AppSize.s60),
                          Text(
                            AppString.alreadyAccount,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
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
                                  .copyWith(
                                      decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
      ),
    );
    // if (type == 'Login') {
    //   return BlocConsumer<LoginBloc, LoginState>(
    //     listenWhen: (previous, current) => current is LoginActionState,
    //     listener: (context, state) {
    //       if (state.isLoading) {
    //         LoadingScreen.instance().show(
    //           context: context,
    //           text: 'Loading ...',
    //         );
    //       } else {
    //         LoadingScreen.instance().hide();
    //       }
    //       final authError = state.authError;
    //       if (authError != null) {
    //         showAuthError(
    //           authError: authError,
    //           context: context,
    //         );
    //       }
    //       if (state is NavigateToRegisterScreenState) {
    //         Navigator.of(context).pushReplacementNamed('/register');
    //       }
    //     },
    //     buildWhen: (previous, current) => current is! LoginActionState,
    //     builder: (context, state) {
    //       return Scaffold(
    //         body: Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 40.0),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Align(
    //                 alignment: Alignment.topLeft,
    //                 child: Text(
    //                   AppString.login,
    //                   style: Theme.of(context).textTheme.displayMedium,
    //                 ),
    //               ),
    //               const SizedBox(
    //                 height: AppSize.s90,
    //               ),
    //               Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   GenericTextField(
    //                     controller: nameController,
    //                     hintText: AppString.userName,
    //                     icon: const Icon(Icons.person),
    //                     inputType: TextInputType.emailAddress,
    //                   ),
    //                   const SizedBox(
    //                     height: AppSize.s20,
    //                   ),
    //                   GenericTextField(
    //                     controller: passwordController,
    //                     hintText: AppString.password,
    //                     icon: const Icon(Icons.key),
    //                     isPassword: true,
    //                     obscuringChar: '◉',
    //                   ),
    //                   const SizedBox(height: AppSize.s36),
    //                   TextButton(
    //                     onPressed: () async {
    //                       loginBloc.add(
    //                         ClickedLoginButtonEvent(
    //                             userName: nameController.text,
    //                             password: passwordController.text),
    //                       );
    //                     },
    //                     child: Text(
    //                       AppString.login,
    //                       style: Theme.of(context)
    //                           .textTheme
    //                           .labelMedium!
    //                           .copyWith(decoration: TextDecoration.underline),
    //                     ),
    //                   ),
    //                   const SizedBox(height: AppSize.s60),
    //                   Text(
    //                     AppString.noAccount,
    //                     style:
    //                         Theme.of(context).textTheme.labelMedium!.copyWith(
    //                               color: ColorManager.white,
    //                               fontSize: AppSize.s14,
    //                             ),
    //                   ),
    //                   const SizedBox(height: AppSize.s8),
    //                   TextButton(
    //                     onPressed: () {
    //                       loginBloc.add(ClickedToNavigateRegisterEvent());
    //                     },
    //                     child: Text(
    //                       AppString.registerHere,
    //                       style: Theme.of(context)
    //                           .textTheme
    //                           .labelMedium!
    //                           .copyWith(decoration: TextDecoration.underline),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     },
    //   );
    // } else {
    //   return BlocConsumer<RegisterBloc, RegisterState>(
    //     listenWhen: (previous, current) => current is RegisterActionState,
    //     listener: (context, state) {
    //       if (state.isLoading) {
    //         LoadingScreen.instance().show(
    //           context: context,
    //           text: 'Loading ...',
    //         );
    //       } else {
    //         LoadingScreen.instance().hide();
    //       }
    //       final authError = state.authError;
    //       if (authError != null) {
    //         showAuthError(
    //           authError: authError,
    //           context: context,
    //         );
    //       }
    //       if (state is NavigateToLoginScreenState) {
    //         Navigator.of(context).pushReplacementNamed('/login');
    //       }
    //     },
    //     buildWhen: (previous, current) => current is! RegisterActionState,
    //     builder: (context, state) {
    //       return Scaffold(
    //         body: Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 40.0),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Align(
    //                 alignment: Alignment.topLeft,
    //                 child: Text(
    //                   AppString.register,
    //                   style: Theme.of(context).textTheme.displayMedium,
    //                 ),
    //               ),
    //               const SizedBox(
    //                 height: AppSize.s90,
    //               ),
    //               Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   GenericTextField(
    //                     controller: nameController,
    //                     hintText: AppString.userName,
    //                     icon: const Icon(Icons.person),
    //                     inputType: TextInputType.emailAddress,
    //                   ),
    //                   const SizedBox(
    //                     height: AppSize.s20,
    //                   ),
    //                   GenericTextField(
    //                     controller: passwordController,
    //                     hintText: AppString.password,
    //                     icon: const Icon(Icons.key),
    //                     isPassword: true,
    //                     obscuringChar: '◉',
    //                   ),
    //                   const SizedBox(height: AppSize.s36),
    //                   TextButton(
    //                     onPressed: () async {
    //                       registerBloc.add(
    //                         ClickedRegisterButtonEvent(
    //                           userName: nameController.text,
    //                           password: passwordController.text,
    //                         ),
    //                       );
    //                       // appAuthBloc.add(const AppAuthEventLogOut());
    //                     },
    //                     child: Text(
    //                       AppString.register,
    //                       style: Theme.of(context)
    //                           .textTheme
    //                           .labelMedium!
    //                           .copyWith(decoration: TextDecoration.underline),
    //                     ),
    //                   ),
    //                   const SizedBox(height: AppSize.s60),
    //                   Text(
    //                     AppString.alreadyAccount,
    //                     style:
    //                         Theme.of(context).textTheme.labelMedium!.copyWith(
    //                               color: ColorManager.white,
    //                               fontSize: AppSize.s14,
    //                             ),
    //                   ),
    //                   const SizedBox(height: AppSize.s8),
    //                   TextButton(
    //                     onPressed: () {
    //                       registerBloc.add(ClickedToNavigateLoginEvent());
    //                     },
    //                     child: Text(
    //                       AppString.loginHere,
    //                       style: Theme.of(context)
    //                           .textTheme
    //                           .labelMedium!
    //                           .copyWith(decoration: TextDecoration.underline),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     },
    //   );
    // }
    // return BlocConsumer(
    //   listener: (context, state) {
    //     // TODO: implement listener
    //   },
    //   builder: (context, state) {
    //     return Scaffold(
    //       body: Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 40.0),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Align(
    //               alignment: Alignment.topLeft,
    //               child: Text(
    //                 type == 'Login' ? AppString.login : AppString.register,
    //                 style: Theme.of(context).textTheme.displayMedium,
    //               ),
    //             ),
    //             const SizedBox(
    //               height: AppSize.s90,
    //             ),
    //             Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 GenericTextField(
    //                   controller: nameController,
    //                   hintText: AppString.userName,
    //                   icon: const Icon(Icons.person),
    //                   inputType: TextInputType.emailAddress,
    //                 ),
    //                 const SizedBox(
    //                   height: AppSize.s20,
    //                 ),
    //                 GenericTextField(
    //                   controller: passwordController,
    //                   hintText: AppString.password,
    //                   icon: const Icon(Icons.key),
    //                   isPassword: true,
    //                   obscuringChar: '◉',
    //                 ),
    //                 const SizedBox(height: AppSize.s36),
    //                 TextButton(
    //                   onPressed: () async {
    //                     if (type == 'Login') {
    //                       loginBloc.add(
    //                         ClickedLoginButtonEvent(
    //                             userName: nameController.text,
    //                             password: passwordController.text),
    //                       );
    //                     } else {
    //                       registerBloc.add(
    //                         ClickedRegisterButtonEvent(
    //                           userName: nameController.text,
    //                           password: passwordController.text,
    //                         ),
    //                       );
    //                       // appAuthBloc.add(const AppAuthEventLogOut());
    //                     }
    //                   },
    //                   child: Text(
    //                     type == 'Login' ? AppString.login : AppString.register,
    //                     style: Theme.of(context)
    //                         .textTheme
    //                         .labelMedium!
    //                         .copyWith(decoration: TextDecoration.underline),
    //                   ),
    //                 ),
    //                 const SizedBox(height: AppSize.s60),
    //                 Text(
    //                   type == 'Login'
    //                       ? AppString.noAccount
    //                       : AppString.alreadyAccount,
    //                   style: Theme.of(context).textTheme.labelMedium!.copyWith(
    //                         color: ColorManager.white,
    //                         fontSize: AppSize.s14,
    //                       ),
    //                 ),
    //                 const SizedBox(height: AppSize.s8),
    //                 TextButton(
    //                   onPressed: () {
    //                     print('type $type');
    //                     type == 'Login'
    //                         ? loginBloc.add(ClickedToNavigateRegisterEvent())
    //                         : registerBloc.add(ClickedToNavigateLoginEvent());
    //                   },
    //                   child: Text(
    //                     type == 'Login'
    //                         ? AppString.registerHere
    //                         : AppString.loginHere,
    //                     style: Theme.of(context)
    //                         .textTheme
    //                         .labelMedium!
    //                         .copyWith(decoration: TextDecoration.underline),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}
