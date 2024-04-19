import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/styles_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/value_manager.dart';
import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const SettingTile({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: onTap,
          style: const ButtonStyle(
            padding: MaterialStatePropertyAll(
              EdgeInsets.all(0.0),
            ),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            text,
            style: getRegularStyle(
                color: ColorManager.primary, fontSize: AppSize.s16),
          ),
        ),
      ],
    );
  }
}
