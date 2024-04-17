import 'package:boost_e_skills/shared/widgets/generic_app_bar.dart';
import 'package:flutter/material.dart';

class SelectCategoryScreen extends StatelessWidget {
  const SelectCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genericAppBar(context, 'Select category', false),
      body: Center(
        child: TextButton(
          onPressed: () async {},
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
