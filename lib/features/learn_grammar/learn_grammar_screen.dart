import 'package:boost_e_skills/features/home/models/topics_model.dart';
import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/fonts_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/strings_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/value_manager.dart';
import 'package:boost_e_skills/shared/widgets/generic_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart' as html;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LearnGrammarScreen extends StatelessWidget {
  final BasicLesson lesson;

  const LearnGrammarScreen({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genericAppBar(context, AppString.grammarAppTitle, true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: html.Html(
              data: lesson.description,
              style: {
                'p': html.Style(
                  fontSize: html.FontSize(AppSize.s16), // Set font size
                  color: ColorManager.white, // Set text color
                  lineHeight:
                      const html.LineHeight(1.5), // Optional: Set line height
                ),
                'h1': html.Style(
                  fontSize: html.FontSize(AppSize.s18), // Set font size
                  color: ColorManager.white, // Set text color
                  lineHeight:
                      const html.LineHeight(1.5), // Optional: Set line height
                ),
                'li': html.Style(
                  fontSize: html.FontSize(AppSize.s14), // Set font size
                  color: ColorManager.white, // Set text color
                  lineHeight:
                      const html.LineHeight(1.5), // Optional: Set line height
                ),
                // Additional styles can be added here for other tags
              },
            ),
          ),
        ),
      ),
    );
  }
}
