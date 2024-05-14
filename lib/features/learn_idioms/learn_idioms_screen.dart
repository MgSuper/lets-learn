// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:boost_e_skills/core/models/topics_model.dart';
import 'package:boost_e_skills/shared/widgets/custom_shimmers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:boost_e_skills/features/learn_grammar/bloc/grammar_bloc.dart';
import 'package:boost_e_skills/features/learn_idioms/widgets/idiom_card.dart';
import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/fonts_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/strings_manager.dart';
import 'package:boost_e_skills/shared/widgets/generic_app_bar.dart';

class LearnIdiomsScreen extends HookWidget {
  final BasicLesson lesson;
  final String topic;

  const LearnIdiomsScreen({
    Key? key,
    required this.lesson,
    required this.topic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final grammarBloc =
        useMemoized(() => BlocProvider.of<GrammarBloc>(context));
    // final homeBloc = useMemoized(() => locator<HomeBloc>());

    useEffect(() {
      grammarBloc.add(LoadGrammar(lessonId: lesson.id, topic: topic));
      return null; // Optional cleanup to mimic componentWillUnmount
    }, const []); // Empty array means this effect runs once on mount.
    return Scaffold(
      appBar: genericAppBar(context, AppString.learnNewWord, true, false),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Explanation',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontSize: FontSize.s24),
                        // Add any Markdown styling you need
                      ),
                    ),
                    SizedBox(height: 20.h),
                    BlocBuilder<GrammarBloc, GrammarState>(
                      bloc: grammarBloc,
                      builder: (context, state) {
                        if (state is GrammarLearnLoading) {
                          return CustomShimmers.rounded(
                            width: 50.w,
                            height: 30.h,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.w),
                            ),
                          );
                        } else if (state is GrammarLoaded) {
                          return Column(
                            children: [
                              state.isLearned
                                  ? Icon(
                                      Icons.check_circle,
                                      color: ColorManager.cerulean,
                                    )
                                  : ElevatedButton(
                                      onPressed: () {
                                        BlocProvider.of<GrammarBloc>(context)
                                            .add(
                                          MarkLessonAsLearned(
                                            userId: FirebaseAuth
                                                .instance.currentUser!.uid,
                                            lessonId: state.lesson.id,
                                            topicName: 'idioms',
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        AppString.markAsLearned,
                                      ),
                                    ),
                            ],
                          );
                        } else if (state is GrammarLearnError) {
                          return Text('Error: ${state.error}');
                        }
                        return const SizedBox
                            .shrink(); // Placeholder for other states
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0.h,
                ),
                Text(
                  lesson.description!,
                  style: Theme.of(context).textTheme.labelMedium!,
                  // Add any Markdown styling you need
                ),
                SizedBox(
                  height: 20.0.h,
                ),
                IdiomCard(
                  front: lesson.word!, // Example idiom
                  back: lesson.usage!, // Explanation of the idiom
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
