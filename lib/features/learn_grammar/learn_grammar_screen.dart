import 'package:boost_e_skills/features/home/models/topics_model.dart';
import 'package:boost_e_skills/shared/utils/resources/fonts_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/strings_manager.dart';
import 'package:boost_e_skills/shared/widgets/generic_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LearnGrammarScreen extends StatelessWidget {
  final BasicLesson lesson;

  const LearnGrammarScreen({super.key, required this.lesson});

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
              Text(
                'Explanation',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(fontSize: FontSize.s24),
                // Add any Markdown styling you need
              ),
            ],
          ),
        ),
      ),
    );
  }
}
