import 'package:boost_e_skills/features/auth/model/app_user_model.dart';
import 'package:boost_e_skills/features/settings/bloc/settings_bloc.dart';
import 'package:boost_e_skills/locator.dart';
import 'package:boost_e_skills/shared/utils/dialogs/logout_dialog.dart';
import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/strings_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/styles_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/value_manager.dart';
import 'package:boost_e_skills/shared/widgets/generic_app_bar.dart';
import 'package:flutter/material.dart';

class SettingsContents extends StatelessWidget {
  final AppUserModel appUserModel;
  const SettingsContents({super.key, required this.appUserModel});

  @override
  Widget build(BuildContext context) {
    final SettingsBloc settingsBloc = locator<SettingsBloc>();
    return Scaffold(
      appBar: genericAppBar(context, AppString.myProfile, false),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            ListTile(
              minVerticalPadding: AppSize.s14,
              leading: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: ColorManager.white),
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
                  borderRadius: BorderRadius.circular(
                    AppPadding.p14,
                  ),
                  border: Border.all(color: ColorManager.white),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () async {},
                            style: const ButtonStyle(
                              padding: MaterialStatePropertyAll(
                                EdgeInsets.all(0.0),
                              ),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'About Me',
                              style: getRegularStyle(
                                  color: ColorManager.white,
                                  fontSize: AppSize.s16),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () async {
                              final shouldLogOut =
                                  await showLogOutDialog(context);
                              if (shouldLogOut) {
                                settingsBloc.add(LogoutEvent());
                              }
                            },
                            style: const ButtonStyle(
                              padding: MaterialStatePropertyAll(
                                EdgeInsets.all(0.0),
                              ),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Sign Out',
                              style: getRegularStyle(
                                  color: ColorManager.white,
                                  fontSize: AppSize.s16),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () async {},
                            style: const ButtonStyle(
                              padding: MaterialStatePropertyAll(
                                EdgeInsets.all(0.0),
                              ),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Other settings',
                              style: getRegularStyle(
                                  color: ColorManager.white,
                                  fontSize: AppSize.s16),
                            ),
                          ),
                        ],
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
