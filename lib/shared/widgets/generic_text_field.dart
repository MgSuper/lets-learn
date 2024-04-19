import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:flutter/material.dart';

class GenericTextField extends StatelessWidget {
  const GenericTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.icon,
    this.inputType,
    this.isPassword,
    this.obscuringChar,
    this.validator,
    this.readOnly,
  });

  final TextEditingController controller;
  final String hintText;
  final Icon? icon;
  final TextInputType? inputType;
  final bool? isPassword;
  final String? obscuringChar;
  final String? Function(String?)? validator;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: icon,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.error, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.error, width: 1.0),
        ),
        errorMaxLines: 3,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: inputType,
      keyboardAppearance: Brightness.dark,
      obscureText: isPassword == true ? true : false,
      obscuringCharacter: '◉',
      style: const TextStyle(
        letterSpacing: 1.5,
      ),
      // textAlign: TextAlign.center,
      readOnly: readOnly ?? false,
      validator: validator,
    );
  }
}
