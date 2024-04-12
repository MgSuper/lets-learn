import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/value_manager.dart';
import 'package:flutter/material.dart';

class WelcomeContents extends StatelessWidget {
  final String image, title, description;
  const WelcomeContents({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(
          image,
          height: 250,
        ),
        const Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: ColorManager.white,
                fontSize: AppSize.s28,
              ),
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelSmall!,
        ),
        const Spacer(),
      ],
    );
  }
}
