import 'package:flutter/material.dart';

class ReusableAppBar extends StatelessWidget {
  const ReusableAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final List<(String, ThemeMode)> _themes = const [
      ('Dark', ThemeMode.dark),
      ('Light', ThemeMode.light),
      ('System', ThemeMode.system),
    ];
    return AppBar(
      actions: [],
    );
  }
}
