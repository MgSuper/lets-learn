import 'package:boost_e_skills/shared/utils/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<bool> showLogOutDialog(
    // on which it has to build display itself
    BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Logout',
    content: 'Are you sure you want to logout?',
    optionBuilder: () => {
      'Cancel': false,
      'Log out': true,
    },
  ).then((value) =>
      value ?? false); // if the dialog is cancelled by tapping outside,
  // we're simply say we have no value to return
}
