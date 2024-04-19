import 'package:boost_e_skills/features/home/bloc/home_bloc.dart';
import 'package:boost_e_skills/features/home/widgets/list_tile_shimmer.dart';
import 'package:boost_e_skills/features/home/widgets/vacab_category_card.dart';
import 'package:boost_e_skills/features/learn_grammar/learn_grammar_screen.dart';
import 'package:boost_e_skills/features/learn_idioms/learn_idioms_screen.dart';
import 'package:boost_e_skills/features/learn_vocabulary/learn_vocabulary_screen.dart';
import 'package:boost_e_skills/features/vocab_list/vocab_list.dart';
import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/strings_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/value_manager.dart';
import 'package:boost_e_skills/shared/widgets/custom_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedTab extends StatelessWidget {
  final String topic;
  final HomeBloc homeBloc;

  const AnimatedTab({super.key, required this.topic, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        print('stateeeee $state');
        if (state is HomeLoading) {
          return const ListTileShimmer();
        } else if (state is HomeLoaded) {
          final lessons = state.topics.basicLesson ?? [];
          return ListView.builder(
            padding: EdgeInsets.only(top: 60.h, left: 5.w, right: 5.w),
            itemCount: lessons.length,
            itemBuilder: (context, index) {
              final lesson = lessons[index];
              return CustomList(
                type: 'idiom & grammar',
                name: lesson.id,
                onTap: () {
                  switch (topic) {
                    case 'grammar':
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LearnGrammarScreen(lesson: lesson),
                        ),
                      );
                      break;
                    case 'idioms':
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LearnIdiomsScreen(lesson: lesson),
                        ),
                      );
                    default:
                  }
                },
              );
            },
          );
        } else if (state is VocabCategoryLoaded) {
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
                          builder: (context) =>
                              VocabList(vocabCategory: state.categories[index]),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          );
        } else if (state is HomeLoadError) {
          return Text("Error: ${state.message}");
        }
        return Container();
      },
    );
  }
}
