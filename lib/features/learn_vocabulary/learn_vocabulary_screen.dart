import 'package:boost_e_skills/core/models/vocab_model.dart';
import 'package:boost_e_skills/features/learn_vocabulary/blocs/vocabulary/vocabulary_bloc.dart';
import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/fonts_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/strings_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/value_manager.dart';
import 'package:boost_e_skills/shared/widgets/custom_shimmers.dart';
import 'package:boost_e_skills/shared/widgets/generic_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LearnVocabularyScreen extends HookWidget {
  final VocabularyWord lesson;
  final String categoryID;

  const LearnVocabularyScreen(
      {super.key, required this.lesson, required this.categoryID});

  @override
  Widget build(BuildContext context) {
    // Access the GrammarBloc
    // GrammarBloc grammarBloc = BlocProvider.of<GrammarBloc>(context);

    final vocabBloc =
        useMemoized(() => BlocProvider.of<VocabularyBloc>(context));
    // final homeBloc = useMemoized(() => locator<HomeBloc>());

    useEffect(() {
      vocabBloc
          .add(FetchVocabulary(vocabId: lesson.id, categoryId: categoryID));
      return null; // Optional cleanup to mimic componentWillUnmount
    }, const []); // Empty array means this effect runs once on mount.
    return Scaffold(
      appBar: genericAppBar(context, AppString.learnNewWord, true, false),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.only(left: 18.0.w, right: 18.0.w, bottom: 18.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                fontSize: FontSize.s24,
                                color: ColorManager.primary),
                        // Add any Markdown styling you need
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    BlocBuilder<VocabularyBloc, VocabularyState>(
                      bloc: vocabBloc,
                      builder: (context, state) {
                        if (state is VocabularyLoading) {
                          return CustomShimmers.rounded(
                            width: 50.w,
                            height: 30.h,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.w),
                            ),
                          );
                        } else if (state is VocabularyLoaded) {
                          return Container(
                            padding: EdgeInsets.zero,
                            child: state.isLearned
                                ? Icon(
                                    Icons.check_circle,
                                    color: ColorManager.cerulean,
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      BlocProvider.of<VocabularyBloc>(context)
                                          .add(
                                        MarkVocabAsLearned(
                                          userId: FirebaseAuth
                                              .instance.currentUser!.uid,
                                          vocabId: state.lesson.id,
                                          categoryId: categoryID,
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      AppString.markAsLearned,
                                    ),
                                  ),
                          );
                        } else if (state is VocabularyError) {
                          return Text('Error: ${state.message}');
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
      ),
    );
  }
}
