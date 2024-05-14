import 'package:boost_e_skills/features/home/bloc/home_bloc.dart';
import 'package:boost_e_skills/features/home/widgets/list_tile_shimmer.dart';
import 'package:boost_e_skills/features/home/widgets/vacab_category_card.dart';
import 'package:boost_e_skills/features/learn_grammar/learn_grammar_screen.dart';
import 'package:boost_e_skills/features/learn_idioms/learn_idioms_screen.dart';
import 'package:boost_e_skills/features/learn_vocabulary/blocs/vocab_category/vocab_category_bloc.dart';
import 'package:boost_e_skills/features/learn_vocabulary/vocab_list/vocab_list.dart';
import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/value_manager.dart';
import 'package:boost_e_skills/shared/widgets/custom_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedTab extends StatelessWidget {
  final String topic;
  final HomeBloc? homeBloc;
  final VocabCategoryBloc? vocabCategoryBloc;

  const AnimatedTab(
      {super.key, required this.topic, this.homeBloc, this.vocabCategoryBloc});

  @override
  Widget build(BuildContext context) {
    if (topic == 'grammar' || topic == 'idioms') {
      return BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const ListTileShimmer(type: 'grammar & idioms');
          } else if (state is HomeLoaded) {
            final lessons = state.topics.basicLesson ?? [];
            return ListView.builder(
              padding: EdgeInsets.only(top: 60.h, left: 18.w, right: 18.w),
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                final lesson = lessons[index];
                final isLessonLearned = state.progress
                    .any((p) => p.lessonId == lesson.word && p.isLearned);
                return CustomList(
                  type: 'idiom & grammar',
                  name: lesson.word,
                  isLearned: isLessonLearned,
                  isFirst: index == 0, // True if it's the first item
                  isLast:
                      index == lessons.length - 1, // True if it's the last item
                  onTap: () {
                    switch (topic) {
                      case 'grammar':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LearnGrammarScreen(
                                lesson: lesson, topic: topic),
                          ),
                        );
                        break;
                      case 'idioms':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LearnIdiomsScreen(
                              lesson: lesson,
                              topic: topic,
                            ),
                          ),
                        );
                      default:
                    }
                  },
                );
              },
            );
          } else if (state is HomeLoadError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return Container();
        },
      );
    } else {
      return BlocBuilder<VocabCategoryBloc, VocabCategoryState>(
        builder: (context, state) {
          if (state is VocabCategoryLoading) {
            return const ListTileShimmer(
              type: '',
            );
          }
          if (state is VocabCategoryError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          if (state is VocabCategoryLoaded) {
            return ListView.builder(
              padding: EdgeInsets.only(top: 60.h, left: 5.w, right: 5.w),
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                return Wrap(
                  children: [
                    VocabCategoryCard(
                      text: state.categories[index].name,
                      textStyle:
                          Theme.of(context).textTheme.labelMedium!.copyWith(
                                fontSize: AppSize.s16,
                                color: ColorManager.primary,
                              ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => VocabList(
                                vocabCategory: state.categories[index]),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            );
          }
          return Container();
        },
      );
    }
  }
}
