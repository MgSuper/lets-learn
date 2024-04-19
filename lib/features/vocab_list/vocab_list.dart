import 'package:boost_e_skills/features/home/models/vocab_model.dart';
import 'package:boost_e_skills/features/home/vocab_bloc/vocabulary/vocabulary_bloc.dart';
import 'package:boost_e_skills/features/learn_vocabulary/learn_vocabulary_screen.dart';
import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/strings_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/value_manager.dart';
import 'package:boost_e_skills/shared/widgets/custom_list.dart';
import 'package:boost_e_skills/shared/widgets/generic_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VocabList extends StatelessWidget {
  final VocabCategory vocabCategory;

  const VocabList({super.key, required this.vocabCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genericAppBar(context, vocabCategory.name, true),
      body: BlocProvider(
        create: (_) => VocabularyBloc()..add(FetchVocabulary(vocabCategory.id)),
        child: BlocBuilder<VocabularyBloc, VocabularyState>(
          builder: (context, state) {
            if (state is VocabularyLoading) {
              return const CircularProgressIndicator();
            } else if (state is VocabularyLoaded) {
              return ListView.builder(
                itemCount: state.words.length,
                itemBuilder: (context, index) {
                  return CustomList(
                    type: 'vocab',
                    word: state.words[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LearnVocabularyScreen(lesson: state.words[index]),
                        ),
                      );
                    },
                  );
                },
              );
            } else if (state is VocabularyError) {
              return Text('Error: ${state.message}');
            }
            return const Text('No data available');
          },
        ),
      ),
    );
  }
}
