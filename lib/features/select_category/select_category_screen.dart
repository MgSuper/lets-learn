import 'package:boost_e_skills/features/auth/app_auth_bloc/app_auth_bloc.dart';
import 'package:boost_e_skills/locator.dart';
import 'package:boost_e_skills/shared/utils/dialogs/logout_dialog.dart';
import 'package:boost_e_skills/shared/widgets/generic_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectCategoryScreen extends StatelessWidget {
  const SelectCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genericAppBar('Select category'),
      body: Center(
        child: TextButton(
          onPressed: () async {},
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
