import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/styles_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/value_manager.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget genericAppBar(String title) {
  return AppBar(
    automaticallyImplyLeading: false,
    centerTitle: false,
    title: Text(
      title,
      style: getRegularStyle(
        color: ColorManager.white,
        fontSize: AppSize.s20,
      ),
    ),
    backgroundColor: Colors.transparent,
    elevation: AppSize.s0,
  );
}
