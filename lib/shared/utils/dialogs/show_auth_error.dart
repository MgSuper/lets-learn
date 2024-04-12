import 'package:boost_e_skills/features/auth/auth_error/auth_error.dart';
import 'package:boost_e_skills/shared/utils/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showAuthError({
  // on which it has to build display itself
  required AuthError authError,
  required BuildContext context,
}) {
  return showGenericDialog<void>(
    context: context,
    title: authError.dialogTitle,
    content: authError.dialogText,
    optionBuilder: () => {
      'OK': true,
    },
  ); // if the dialog is cancelled by tapping outside,
  // we're simply say we have no value to return
}
