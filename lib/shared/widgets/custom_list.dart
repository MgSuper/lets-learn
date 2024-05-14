// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:boost_e_skills/core/models/vocab_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/value_manager.dart';

class CustomList extends StatelessWidget {
  final String type;
  final VocabularyWord? word;
  final VoidCallback? onTap;
  final String? name;
  final bool? isLearned; // Add this parameter
  final bool isFirst; // Add this
  final bool isLast; // Add this
  final String? vocabCategoryID;
  const CustomList({
    Key? key,
    required this.type,
    this.word,
    this.onTap,
    this.name,
    this.isLearned,
    this.isFirst = false, // Default as false
    this.isLast = false, // Default as false
    this.vocabCategoryID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap!,
      child: Row(
        children: [
          Expanded(
            flex: 0,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Conditional to show line if not the first item
                // if (!isFirst) // Conditionally display the line if not the first item
                //   Container(
                //     width: 1,
                //     height: 20.h,
                //     color: Colors.grey,
                //   ),

                CircleAvatar(
                  radius: 15.sp,
                  backgroundColor:
                      isLearned! ? ColorManager.cerulean : ColorManager.grey,
                  child: isLearned!
                      ? Icon(
                          Icons.check,
                          color: ColorManager.white,
                          size: 20.sp,
                        )
                      : Icon(
                          Icons.lock_outline,
                          color: ColorManager.white,
                          size: 20.sp,
                        ),
                ),
                // Line continuing downwards, make conditional if not the last item

                // if (!isLast) // Conditionally display the line if not the last item
                //   Container(
                //     width: 1,
                //     height: 20.h,
                //     color: Colors.grey,
                //   ),
              ],
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
              child: Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        type == 'vocab' ? word!.word : name!,
                        maxLines: 1,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                fontSize: AppSize.s16,
                                color: ColorManager.primary),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: ColorManager.primary,
                      size: AppSize.s16,
                    ),
                    // to add Icon or Image that reflect the category
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
