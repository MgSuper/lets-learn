import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ListTileShimmer extends StatelessWidget {
  const ListTileShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 50.h),
      itemCount: 7,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!, // Base color of the shimmer
          highlightColor: Colors.grey[100]!, // Highlight color of the shimmer
          child: ListTile(
            title: Container(
              height: 20, // Typical height for a text line
              width: double.infinity,
              color: Colors.white, // Background color of the shimmer area
            ),
          ),
        );
      },
    );
  }
}
