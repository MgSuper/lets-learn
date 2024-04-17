import 'package:boost_e_skills/features/home/bloc/home_bloc.dart';
import 'package:boost_e_skills/features/home/widgets/list_tile_shimmer.dart';
import 'package:boost_e_skills/features/learn_grammar/learn_grammar_screen.dart';
import 'package:boost_e_skills/features/learn_idioms/learn_idioms_screen.dart';
import 'package:boost_e_skills/features/learn_vocabulary/learn_vocabulary_screen.dart';
import 'package:boost_e_skills/shared/utils/resources/value_manager.dart';
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
        if (state is HomeLoading) {
          return const ListTileShimmer();
        } else if (state is HomeLoaded) {
          final lessons = state.topics.basicLesson ?? [];
          return ListView.builder(
            padding: EdgeInsets.only(top: 50.h),
            itemCount: lessons.length,
            itemBuilder: (context, index) {
              final lesson = lessons[index];
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: AnimationController(
                      duration: Duration(milliseconds: 300 * (index + 1)),
                      vsync: Navigator.of(context),
                    )..forward(),
                    curve: Curves.easeOut,
                  ),
                ),
                child: ListTile(
                  title: Text(
                    lesson.id,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontSize: AppSize.s16,
                        decoration: TextDecoration.underline),
                  ),
                  onTap: () {
                    print('topic $topic');
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
                      case 'vocabulary':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                LearnVocabularyScreen(lesson: lesson),
                          ),
                        );
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
                ),
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
