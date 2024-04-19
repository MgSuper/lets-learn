import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:boost_e_skills/shared/utils/resources/strings_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/value_manager.dart';
import 'package:boost_e_skills/shared/widgets/generic_app_bar.dart';

class SettingShimmer extends StatelessWidget {
  const SettingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genericAppBar(context, AppString.myProfile, false),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            buildShimmer(
              child: Column(
                children: [
                  ListTile(
                    minVerticalPadding: AppSize.s14,
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    title: Container(
                      height: 14,
                      color: Colors.grey.shade400,
                    ),
                    subtitle: Container(
                      height: 14,
                      color: Colors.grey.shade400,
                      margin: const EdgeInsets.only(top: 5),
                    ),
                  ),
                  ListTile(
                    title: Container(
                      height: 14,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14),
              child: buildShimmer(
                child: Container(
                  height: 130.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(AppPadding.p14),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                    child: Column(
                      children: [
                        Container(height: 20, color: Colors.grey.shade400),
                        const SizedBox(height: 10),
                        Container(height: 20, color: Colors.grey.shade400),
                        const SizedBox(height: 10),
                        Container(height: 20, color: Colors.grey.shade400),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  Widget buildShimmer({required Widget child}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey[100]!,
      child: child,
    );
  }

  PreferredSizeWidget buildShimmerAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Shimmer.fromColors(
        period: const Duration(milliseconds: 1500),
        baseColor: Colors.grey.shade400,
        highlightColor: Colors.grey[100]!,
        child: AppBar(
          leading: Icon(Icons.menu,
              color: Colors.grey[
                  300]!), // Replace with actual leading widget if necessary
          title: Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: 20,
            color: Colors.grey.shade400,
          ),
          actions: [
            Icon(Icons.notifications,
                color: Colors.grey[
                    300]!), // Replace with actual action icons if necessary
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.search, color: Colors.grey.shade400),
            ),
          ],
        ),
      ),
    );
  }
}
