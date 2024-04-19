// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VocabCategoryCard extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final VoidCallback onTap;

  const VocabCategoryCard({
    Key? key,
    required this.text,
    this.textStyle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(0.5),
        margin: EdgeInsets.symmetric(vertical: 7.h, horizontal: 15.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.h),
        ),
        child: Container(
          width: double.infinity,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: textStyle,
                textAlign: TextAlign.center,
              ),
              // to add Icon or Image that reflect the category
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: ColorManager.primary,
                size: AppSize.s16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
