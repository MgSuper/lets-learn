// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import 'package:boost_e_skills/shared/widgets/custom_shimmers.dart';

class ListTileShimmer extends StatelessWidget {
  final String type;
  const ListTileShimmer({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(
          top: type == 'vocab' ? 0.h : 60.h,
          left: 18.w,
          right: 18.0.w), // Assuming this works as intended
      itemCount: 7,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Expanded(
              flex: 0,
              child: CustomShimmers.circular(
                width: 33.w,
                height: 33.h,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              flex: 9,
              child: Card(
                elevation: 4,
                shadowColor: Colors.grey.withOpacity(0.5),
                margin: EdgeInsets.symmetric(vertical: 10.h),
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
