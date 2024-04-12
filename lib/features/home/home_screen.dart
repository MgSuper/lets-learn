import 'package:boost_e_skills/features/home/bloc/home_bloc.dart';
import 'package:boost_e_skills/features/learn/learn_screen.dart';
import 'package:boost_e_skills/locator.dart';
import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/strings_manager.dart';
import 'package:boost_e_skills/shared/widgets/generic_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 3);
    final homeBloc = locator<HomeBloc>();
    // Add listener to rebuild the widget when the tab changes
    useEffect(() {
      tabController.addListener(() {
        // This is a workaround to trigger a rebuild, you may optimize this further as needed.
        (context as Element).markNeedsBuild();
      });
      return () => tabController.removeListener(() {});
    }, [tabController]);
    // useEffect(() {
    //   void handleTabChange() {
    //     tabBarColor.value = getColorForTabIndex(tabController.index);
    //   }

    //   tabController.addListener(handleTabChange);
    //   return () => tabController.removeListener(handleTabChange);
    // }, [tabController]);

    return Scaffold(
      appBar: genericAppBar(AppString.letslearn),
      body: SafeArea(
        child: SizedBox(
          height: 812.h,
          width: 375.w,
          child: Stack(
            children: <Widget>[
              TabBarView(
                controller: tabController,
                children: <Widget>[
                  buildAnimatedTab(topic: 'grammar', homeBloc: homeBloc),
                  buildAnimatedTab(topic: 'vocabulary', homeBloc: homeBloc),
                  buildAnimatedTab(topic: 'idioms', homeBloc: homeBloc),
                ],
              ),
              Material(
                color: Colors.transparent,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  child: TabBar(
                    controller: tabController,
                    padding: EdgeInsets.zero,
                    indicator: const BoxDecoration(),
                    labelPadding: const EdgeInsets.only(
                      left: 20.0,
                    ),
                    isScrollable: true,
                    tabs: <Widget>[
                      CustomTab(
                          label: 'Grammar', isActive: tabController.index == 0),
                      CustomTab(
                          label: 'Vocabulary',
                          isActive: tabController.index == 1),
                      CustomTab(
                          label: 'Idioms', isActive: tabController.index == 2),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to determine the color based on the tab index
  Color getColorForTabIndex(int index) {
    switch (index) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.green;
      case 2:
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  // Widget buildAnimatedTab(
  //     TabController tabController, int index, String content) {
  //   final isActive = useState(false);

  //   useEffect(() {
  //     void updateState() {
  //       isActive.value = tabController.index == index;
  //     }

  //     tabController.addListener(updateState);
  //     return () => tabController.removeListener(updateState);
  //   }, [tabController, index]);

  //   return Center(
  //     child: AnimatedContainer(
  //       duration: const Duration(milliseconds: 300),
  //       width: isActive.value ? 200 : 100, // Example of changing size
  //       height: isActive.value ? 200 : 100,
  //       color: isActive.value ? Colors.blue : Colors.grey,
  //       alignment: Alignment.center,
  //       child: Text(content,
  //           style: const TextStyle(color: Colors.white, fontSize: 16)),
  //     ),
  //   );
  // }
}

class buildAnimatedTab extends StatelessWidget {
  final String topic;
  final HomeBloc homeBloc;

  buildAnimatedTab({required this.topic, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    homeBloc.add(LoadTopic(topic));
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded) {
          print('state.topics.basicLesson');
          print(state.topics.basicLesson);
          final lessons = state.topics.basicLesson ?? [];
          return ListView.builder(
            padding: EdgeInsets.only(top: 50.h),
            itemCount: lessons.length,
            itemBuilder: (context, index) {
              final lesson = lessons[index];
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: AnimationController(
                      duration: Duration(milliseconds: 300 * (index + 1)),
                      vsync: Navigator.of(context),
                    )..forward(),
                    curve: Curves.easeOut,
                  ),
                ),
                child: ListTile(
                  title: Text(lesson.id),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LearnScreen(lesson: lesson),
                      ),
                    );
                  },
                ),
              );
            },
          );
        } else if (state is HomeLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is HomeLoadError) {
          return Text("Error: ${state.message}");
        }
        return Container(); // Placeholder for other states
      },
    );
  }
}

class CustomTab extends HookWidget {
  final String label;
  final bool isActive;

  const CustomTab({
    Key? key,
    required this.label,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 100),
    );

    final animation = useAnimation(
      ColorTween(begin: Colors.grey, end: Colors.blue)
          .animate(animationController),
    );

    // Define the animation for the text color
    final textColor = useAnimation(
      ColorTween(begin: Colors.white, end: Colors.yellow)
          .animate(animationController),
    );

    // Define the animation for the font size
    final fontSize = useAnimation(
      Tween<double>(begin: 16.0, end: 20.0).animate(animationController),
    );

    useEffect(() {
      if (isActive) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
      return null;
    }, [isActive]);

    return Tab(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: animation,
          borderRadius: BorderRadius.circular(isActive ? 20.0 : 10.0),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
