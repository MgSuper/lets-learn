import 'package:boost_e_skills/shared/utils/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<bool> showRegisterationSuccessDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Success',
    content: 'Registeration success, go back and login',
    optionBuilder: () => {
      'OK': false,
    },
  ).then((value) => value ?? false);
}
