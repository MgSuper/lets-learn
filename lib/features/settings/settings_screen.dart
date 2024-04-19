import 'package:boost_e_skills/features/settings/bloc/settings_bloc.dart';
import 'package:boost_e_skills/features/settings/widgets/setting_shimmer.dart';
import 'package:boost_e_skills/features/settings/widgets/settings_contents.dart';
import 'package:boost_e_skills/shared/utils/dialogs/show_auth_error.dart';
import 'package:boost_e_skills/shared/utils/loading/loading_screen.dart';
import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      listenWhen: (previous, current) => current is SettingsActionState,
      listener: (context, state) {
        if (state is LogoutState && state.isLoading) {
          LoadingScreen.instance().show(
            context: context,
            text: 'Loading ...',
          );
        } else {
          LoadingScreen.instance().hide();
        }
        if (state is LogoutState && state.authError == null) {
          final authError = state.authError;
          if (authError != null) {
            showAuthError(
              authError: authError,
              context: context,
            );
          }
        }
        if (state is LogoutState && !state.isLoading) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/login', (route) => false);
        }
      },
      buildWhen: (previous, current) => current is! SettingsActionState,
      builder: (context, state) {
        if (state is UserDataLoading) {
          return const SettingShimmer();
        }
        if (state is UserDataLoaded) {
          return SettingsContents(appUserModel: state.user);
        }
        if (state is UserDataError) {
          return const Center(
            child: Text('Error'),
          );
        }
        return Container();
      },
    );
  }
}
