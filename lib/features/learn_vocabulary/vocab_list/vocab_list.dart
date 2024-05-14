import 'package:boost_e_skills/core/models/vocab_model.dart';
import 'package:boost_e_skills/features/home/widgets/list_tile_shimmer.dart';
import 'package:boost_e_skills/features/learn_vocabulary/blocs/vocabularies/vocabularies_bloc.dart';
import 'package:boost_e_skills/features/learn_vocabulary/learn_vocabulary_screen.dart';
import 'package:boost_e_skills/shared/widgets/custom_list.dart';
import 'package:boost_e_skills/shared/widgets/generic_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VocabList extends HookWidget {
  final VocabCategory vocabCategory;

  const VocabList({super.key, required this.vocabCategory});

  @override
  Widget build(BuildContext context) {
    final vocabulariesBloc =
        useMemoized(() => BlocProvider.of<VocabulariesBloc>(context));

    useEffect(() {
      vocabulariesBloc.add(FetchVocabularies(categoryId: vocabCategory.id));
      return null; // Optional cleanup to mimic componentWillUnmount
    }, const []); // Empty array means this effect runs once on mount.

    return Scaffold(
      appBar: genericAppBar(context, vocabCategory.name, true, false),
      body: BlocBuilder<VocabulariesBloc, VocabulariesState>(
        bloc: vocabulariesBloc,
        builder: (context, state) {
          if (state is VocabulariesLoading) {
            return const ListTileShimmer(
              type: 'vocab',
            );
          } else if (state is VocabulariesLoaded) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              itemCount: state.words.length,
              itemBuilder: (context, index) {
                final word = state.words[index];
                final isLessonLearned = state.progress.any((p) {
                  return p.lessonId == word.id && p.isLearned;
                });
                return CustomList(
                  type: 'vocab',
                  word: state.words[index],
                  isLearned: isLessonLearned,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LearnVocabularyScreen(
                          lesson: word,
                          categoryID: vocabCategory.id,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is VocabulariesError) {
            return Text('Error: ${state.message}');
          }
          return const Text('No data available');
        },
      ),
    );
  }
}
