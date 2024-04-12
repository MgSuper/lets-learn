import 'package:boost_e_skills/shared/utils/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shimmer/shimmer.dart';

class AuthScreenShimmer extends HookWidget {
  const AuthScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Shimmer.fromColors(
          baseColor:
              Colors.grey[300]!, // Adjust the base color to match your theme
          highlightColor: Colors
              .grey[100]!, // Adjust the highlight color for the shimmer effect
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity / 5,
                height:
                    AppSize.s48, // Mimics the height of a typical text widget
                color: Colors.white,
              ),
              const SizedBox(
                height: AppSize.s90,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Mimic the text field with a container
                  Container(
                    width: double.infinity,
                    height: AppSize.s48, // Mimics the height of a text field
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                          12), // Optional: if your text fields have rounded corners
                    ),
                  ),
                  const SizedBox(height: AppSize.s20),
                  Container(
                    width: double.infinity,
                    height: AppSize.s48, // Mimics the height of a text field
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(height: 36),
                  Container(
                    width: double.infinity,
                    height: 20, // Mimics the height of a text button
                    color: Colors.white,
                  ),
                  const SizedBox(height: 60),
                  Container(
                    width: double.infinity,
                    height: 20, // Mimics the height of a small text
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
