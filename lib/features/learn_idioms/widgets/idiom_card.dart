import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IdiomCard extends HookWidget {
  final String front;
  final String back;

  const IdiomCard({super.key, required this.front, required this.back});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlipCard(
        fill: Fill
            .fillBack, // Fill the back side of the card to make in the same size as the front.
        direction: FlipDirection.HORIZONTAL, // default
        side: CardSide.FRONT,
        front: Card(
          color: ColorManager.white,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            alignment: Alignment.center,
            height: 200.h,
            child: Text(
              front,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: ColorManager.primary),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        back: Card(
          color: ColorManager.cerulean,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            alignment: Alignment.center,
            height: 200.h,
            child: Text(
              back,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: ColorManager.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
