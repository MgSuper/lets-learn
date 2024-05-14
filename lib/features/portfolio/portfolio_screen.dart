import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/strings_manager.dart';
import 'package:boost_e_skills/shared/widgets/generic_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genericAppBar(context, AppString.myPortfolio, true, true),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                Container(
                  height: 650.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorManager.grey2.withOpacity(0.5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.w),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
