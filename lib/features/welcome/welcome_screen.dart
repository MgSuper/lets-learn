// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:boost_e_skills/features/welcome/bloc/welcome_bloc.dart';
import 'package:boost_e_skills/features/welcome/data/welcome_data.dart';
import 'package:boost_e_skills/features/welcome/widgets/dot_indicator.dart';
import 'package:boost_e_skills/features/welcome/widgets/welcome_contents.dart';
import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late PageController _pageController;
  int _pageIndex = 0;
  // final welcomeBloc = locator<WelcomeBloc>();

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: welcomeData.length,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) => WelcomeContents(
                    image: welcomeData[index].image,
                    title: welcomeData[index].title,
                    description: welcomeData[index].description,
                  ),
                ),
              ),
              BlocBuilder<WelcomeBloc, WelcomeState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...List.generate(
                        welcomeData.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: DotIndicator(
                            isActive: index == _pageIndex,
                          ),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: IconButton(
                          onPressed: () {
                            if (_pageIndex < 2) {
                              _pageController.nextPage(
                                curve: Curves.ease,
                                duration: const Duration(milliseconds: 300),
                              );
                            } else {
                              context.read<WelcomeBloc>().add(
                                    CompleteWelcome(),
                                  );
                              Navigator.of(context).pushNamed('/login');
                            }
                          },
                          icon: _pageIndex == 2
                              ? Text(
                                  'Start',
                                  style:
                                      Theme.of(context).textTheme.labelMedium!,
                                )
                              : SvgPicture.asset(
                                  'assets/welcome/arrow_right.svg',
                                  height: 160,
                                  width: 160,
                                  fit: BoxFit.fill,
                                  colorFilter: ColorFilter.mode(
                                    ColorManager.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
