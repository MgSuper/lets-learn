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
          color: Colors.blue,
          child: Container(
            alignment: Alignment.center,
            height: 200.h,
            child: Text(
              front,
              style: const TextStyle(fontSize: 24, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        back: Card(
          color: Colors.red,
          child: Container(
            alignment: Alignment.center,
            height: 200.h,
            child: Text(
              back,
              style: const TextStyle(fontSize: 24, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
