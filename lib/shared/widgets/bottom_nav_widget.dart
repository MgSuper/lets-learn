import 'package:flutter/material.dart';

class BottomNavWidget extends StatelessWidget {
  final void Function()? onTap;
  final IconData? icon;
  const BottomNavWidget({
    super.key,
    this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // final indexProvider = Provider.of<MainScreenNotifier>();
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 45.0,
        width: 45.0,
        child: Icon(
          icon,
          color: Colors.black,
        ),
      ),
    );
  }
}
