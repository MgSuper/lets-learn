import 'package:boost_e_skills/features/home/models/topics_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class LearnScreen extends StatelessWidget {
  final BasicLesson lesson;

  LearnScreen({required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lesson Detail"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // Use Markdown widget to display content
        child: Markdown(
          data: lesson.content,
          // Add any Markdown styling you need
        ),
      ),
    );
  }
}
