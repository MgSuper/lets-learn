// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:boost_e_skills/features/settings/widgets/setting_tile.dart';
import 'package:flutter/material.dart';

import 'package:boost_e_skills/core/models/app_user_model.dart';
import 'package:boost_e_skills/features/settings/bloc/settings_bloc.dart';
import 'package:boost_e_skills/locator.dart';
import 'package:boost_e_skills/shared/utils/dialogs/logout_dialog.dart';
import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/strings_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/styles_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/value_manager.dart';
import 'package:boost_e_skills/shared/widgets/generic_app_bar.dart';

class SettingsContents extends StatelessWidget {
  final AppUserModel appUserModel;
  const SettingsContents({super.key, required this.appUserModel});

  @override
  Widget build(BuildContext context) {
    final SettingsBloc settingsBloc = locator<SettingsBloc>();
    return Scaffold(
      appBar: genericAppBar(context, AppString.myProfile, false, false),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            ListTile(
              minVerticalPadding: AppSize.s14,
              leading: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorManager.grey2.withOpacity(0.5),
                  ),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Icon(
                  Icons.person,
                  size: AppSize.s50,
                  color: ColorManager.white,
                ),
              ),
              title: Text(
                appUserModel.displayName,
                style: getRegularStyle(
                    color: ColorManager.white, fontSize: AppSize.s18),
              ),
              subtitle: Text(
                appUserModel.id,
                style: getRegularStyle(
                    color: ColorManager.white, fontSize: AppSize.s16),
              ),
            ),
            ListTile(
              title: Text('Account Settings',
                  style: getRegularStyle(
                      color: ColorManager.white, fontSize: AppSize.s16)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorManager.grey2.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(
                    AppPadding.p14,
                  ),
                  border:
                      Border.all(color: ColorManager.grey2.withOpacity(0.5)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 8.0,
                  ),
                  child: Column(
                    children: [
                      SettingTile(
                        text: AppString.myPortfolio,
                        onTap: () {
                          Navigator.of(context).pushNamed('/portfolio');
                        },
                      ),
                      SettingTile(
                        text: 'Sign Out',
                        onTap: () async {
                          final shouldLogOut = await showLogOutDialog(context);
                          if (shouldLogOut) {
                            settingsBloc.add(LogoutEvent());
                          }
                        },
                      ),
                      SettingTile(
                        text: 'Other Settings',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
