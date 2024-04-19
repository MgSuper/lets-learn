// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:boost_e_skills/features/home/models/vocab_model.dart';
import 'package:boost_e_skills/features/learn_vocabulary/learn_vocabulary_screen.dart';
import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/value_manager.dart';

class CustomList extends StatelessWidget {
  final String type;
  final VocabularyWord? word;
  final VoidCallback? onTap;
  final String? name;
  const CustomList({
    Key? key,
    required this.type,
    this.word,
    this.onTap,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap!,
      child: Row(
        children: [
          Column(
            children: <Widget>[
              // Conditional to show line if not the first item
              // if (!isFirst)
              Container(
                width: 1,
                height: 20,
                color: Colors.grey,
              ),
              const CircleAvatar(
                child: Icon(Icons.lock_outline),
                backgroundColor: Colors.grey,
              ),
              // Line continuing downwards, make conditional if not the last item
              // if (!isLast)
              Container(
                width: 1,
                height: 20,
                color: Colors.grey,
              ),
            ],
          ),
          Expanded(
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
                    Expanded(
                      child: Text(
                        type == 'vocab' ? word!.word : name!,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                fontSize: AppSize.s16,
                                color: ColorManager.primary),
                        textAlign: TextAlign.center,
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
