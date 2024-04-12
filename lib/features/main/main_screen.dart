import 'package:boost_e_skills/features/home/home_screen.dart';
import 'package:boost_e_skills/features/main/bloc/main_screen_bloc.dart';
import 'package:boost_e_skills/features/noti/noti_screen.dart';
import 'package:boost_e_skills/features/result/result_screen.dart';
import 'package:boost_e_skills/features/settings/bloc/settings_bloc.dart';
import 'package:boost_e_skills/features/settings/settings_screen.dart';
import 'package:boost_e_skills/locator.dart';
import 'package:boost_e_skills/shared/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> pageList = [
      const HomeScreen(),
      const ResultScreen(),
      const NotiScreen(),
      const SettingsScreen(),
    ];
    final SettingsBloc settingsBloc = locator<SettingsBloc>();
    return Scaffold(
      body: BlocBuilder<MainScreenBloc, MainScreenState>(
        builder: (context, state) {
          if (state is NavTabChangeState) {
            return pageList[state.selectedIndex];
          }
          return Container();
        },
      ),
      bottomNavigationBar: BlocBuilder<MainScreenBloc, MainScreenState>(
        builder: (context, state) {
          if (state is NavTabChangeState) {
            if (state.selectedIndex == 3) {
              settingsBloc.add(FetchUserDataEvent());
            }
            return BottomNavBar(
              pageIndex: state.selectedIndex,
            );
          }
          return Container();
        },
      ),
    );
  }
}
