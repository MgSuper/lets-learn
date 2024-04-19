import 'package:boost_e_skills/features/home/models/topics_model.dart';
import 'package:boost_e_skills/features/home/models/vocab_model.dart';
import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/fonts_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/strings_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/value_manager.dart';
import 'package:boost_e_skills/shared/widgets/generic_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LearnVocabularyScreen extends StatelessWidget {
  final VocabularyWord lesson;

  const LearnVocabularyScreen({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genericAppBar(context, AppString.learnNewWord, true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(18.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(AppSize.s4),
                  ),
                ),
                child: Text(
                  'Explanation',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontSize: FontSize.s24, color: ColorManager.primary),
                  // Add any Markdown styling you need
                ),
              ),
              SizedBox(
                height: 10.0.h,
              ),
              Text(
                lesson.definition,
                style: Theme.of(context).textTheme.labelMedium!,
                // Add any Markdown styling you need
              ),
              SizedBox(
                height: 30.0.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(AppSize.s4),
                  ),
                ),
                child: Text(
                  'Example',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontSize: FontSize.s24, color: ColorManager.primary),
                  // Add any Markdown styling you need
                ),
              ),
              SizedBox(
                height: 10.0.h,
              ),
              Text(
                'Person A :  ${lesson.pOne}',
                style: Theme.of(context).textTheme.labelMedium!,
                // Add any Markdown styling you need
              ),
              SizedBox(
                height: 10.0.h,
              ),
              Text(
                'Person B :  ${lesson.pTwo}',
                style: Theme.of(context).textTheme.labelMedium!,
                // Add any Markdown styling you need
              ),
            ],
          ),
        ),
      ),
    );
  }
}
