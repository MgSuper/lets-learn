import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ListTileShimmer extends StatelessWidget {
  const ListTileShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(
          top: 60.h, left: 5.w, right: 5.w), // Assuming this works as intended
      itemCount: 7,
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          shadowColor: Colors.grey.withOpacity(0.5),
          margin: EdgeInsets.symmetric(vertical: 7.h, horizontal: 15.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.h),
          ),
          child: Shimmer.fromColors(
            period: const Duration(milliseconds: 1500),
            baseColor: Colors.grey.shade400,
            highlightColor: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(8.h),
              ),
              width: double.infinity,
              height: 50.h,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
            ),
          ),
        );
      },
    );
  }
}
