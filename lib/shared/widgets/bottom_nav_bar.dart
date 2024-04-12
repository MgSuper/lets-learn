import 'package:boost_e_skills/features/main/bloc/main_screen_bloc.dart';
import 'package:boost_e_skills/locator.dart';
import 'package:boost_e_skills/shared/widgets/bottom_nav_widget.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class BottomNavBar extends StatelessWidget {
  final int pageIndex;
  const BottomNavBar({
    super.key,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    // No changes needed here for dependency retrieval
    final MainScreenBloc mainScreenBloc = locator<MainScreenBloc>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Updated onTap callback to use specific index for each BottomNavWidget
              BottomNavWidget(
                onTap: () =>
                    mainScreenBloc.add(NavigationTabChanged(tabIndex: 0)),
                icon: pageIndex == 0
                    ? CommunityMaterialIcons.home
                    : CommunityMaterialIcons.home_outline,
              ),
              BottomNavWidget(
                onTap: () =>
                    mainScreenBloc.add(NavigationTabChanged(tabIndex: 1)),
                icon: pageIndex == 1
                    ? CommunityMaterialIcons.heart
                    : CommunityMaterialIcons.heart_outline,
              ),
              BottomNavWidget(
                onTap: () =>
                    mainScreenBloc.add(NavigationTabChanged(tabIndex: 2)),
                icon: pageIndex == 2
                    ? Ionicons.notifications
                    : Ionicons.notifications_outline,
              ),
              BottomNavWidget(
                onTap: () =>
                    mainScreenBloc.add(NavigationTabChanged(tabIndex: 3)),
                icon: pageIndex == 3
                    ? CommunityMaterialIcons.account_settings
                    : CommunityMaterialIcons.account_settings_outline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
