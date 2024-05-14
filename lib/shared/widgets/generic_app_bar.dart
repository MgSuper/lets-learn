import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/styles_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSizeWidget genericAppBar(
    BuildContext context, String title, bool? isAction, bool? isLeading) {
  return AppBar(
    automaticallyImplyLeading: false,
    centerTitle: false,
    leading: isLeading!
        ? Padding(
            padding: EdgeInsets.all(
              16.0.w,
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0.w),
                child: Image.asset('assets/app_icon/app_icon.png')),
          )
        : null,
    title: Text(
      title,
      style: getRegularStyle(
        color: ColorManager.white,
        fontSize: AppSize.s20,
      ),
    ),
    backgroundColor: Colors.transparent,
    elevation: AppSize.s0,
    actions: isAction == true
        ? [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ]
        : [],
  );
}
