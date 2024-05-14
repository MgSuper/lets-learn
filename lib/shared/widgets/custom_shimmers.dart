import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmers extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final double left;
  final double right;
  final double bottom;
  final double top;

  const CustomShimmers._({
    this.width = double.infinity,
    this.height = double.infinity,
    this.left = 0.0,
    this.right = 0.0,
    this.bottom = 0.0,
    this.top = 0.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    Key? key,
  }) : super(key: key);

  const CustomShimmers.square({
    required double width,
    required double height,
    double left = 0.0,
    double right = 0.0,
    double bottom = 0.0,
    double top = 0.0,
  }) : this._(
            width: width,
            height: height,
            left: left,
            right: right,
            bottom: bottom,
            top: top);

  const CustomShimmers.rounded({
    required double width,
    required double height,
    double left = 0.0,
    double right = 0.0,
    double bottom = 0.0,
    double top = 0.0,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(12)),
  }) : this._(
            width: width,
            height: height,
            borderRadius: borderRadius,
            left: left,
            right: right,
            bottom: bottom,
            top: top);

  const CustomShimmers.circular({
    required double width,
    required double height,
    double left = 0.0,
    double right = 0.0,
    double bottom = 0.0,
    double top = 0.0,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(80)),
  }) : this._(
            width: width,
            height: height,
            borderRadius: borderRadius,
            left: left,
            right: right,
            bottom: bottom,
            top: top);

  @override
  Widget build(BuildContext context) => Padding(
        padding:
            EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade400,
          highlightColor: ColorManager.white,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: borderRadius,
            ),
          ),
        ),
      );
}
