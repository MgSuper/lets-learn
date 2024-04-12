// step_6
// we are not hard code this alert to contain specific values
// the purpose of this generic dialog should really be display an alert dialog
// whose title, contents and even buttons and the actions of those buttons or
// the values of those buttons return can be generic and configurable

// go ahead and create some sort of a type defination for the options of this dialog
// but create type signature of the dialog

// the option builder is just a map whose keys are String and it values are some sorts
// of value which we don't actually know about
// and the reason this is generic is that it'll just plug and play right into the function
// which is also using generic
import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/styles_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/value_manager.dart';
import 'package:flutter/material.dart';

// function that return a map
typedef DialogOptionBuilder<T> = Map<String, T?> Function();

// return optional value
// whate generic dialog means is a BuildContext to display the dialog on
// <T> means generic T type
Future<T?> showGenericDialog<T>(
    {required BuildContext context,
    required String title,
    required String content,
    // can see here DialogOptionBuilder really plugged and played really well in here
    // simply because T is a parameter that is brought (from Future<T?>) and it will just
    // plugged into this (DialogOptionBuilder) which also required T. it's not just the name
    // is equal but because it's actually generic and (continue below commnent)
    required DialogOptionBuilder optionBuilder}) {
  // we also have a generic function in here

  // every key in this options map is in fact the title of the action
  final options = optionBuilder();
  return showDialog<T?>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: options.keys.map(
          (optionTitle) {
            final value = options[optionTitle];
            return TextButton(
              onPressed: () {
                if (value != null) {
                  // return a value of the build context or to the presenter if
                  // we have a value in value which is pretty much the value of the
                  // map for that particular key.
                  // pop with a value
                  Navigator.of(context).pop(value);
                } else {
                  // just pop the current context
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                optionTitle,
                style: getRegularStyle(
                  color: ColorManager.primary,
                  fontSize: AppSize.s16,
                ),
              ),
            );
          },
        ).toList(),
      );
    },
  );
}
