import 'package:boost_e_skills/features/home/bloc/home_bloc.dart';
import 'package:boost_e_skills/features/home/widgets/animated_tab.dart';
import 'package:boost_e_skills/features/home/widgets/custom_tab.dart';
import 'package:boost_e_skills/locator.dart';
import 'package:boost_e_skills/shared/utils/resources/strings_manager.dart';
import 'package:boost_e_skills/shared/widgets/generic_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 3);
    final homeBloc = locator<HomeBloc>();
    final currentIndex = useState(0);
    // Add listener to rebuild the widget when the tab changes
    useEffect(() {
      void onTabChanged() {
        currentIndex.value = tabController.index;
        if (tabController.indexIsChanging) {
          String topicName =
              ['grammar', 'vocabulary', 'idioms'][tabController.index];
          homeBloc.add(TabChanged(topicName));
        }
      }

      tabController.addListener(onTabChanged);
      onTabChanged();
      homeBloc.add(TabChanged('grammar'));
      return () => tabController.removeListener(onTabChanged);
    }, [tabController]);

    // useEffect(() {
    //   void onTabChanged() {
    //     currentIndex.value = tabController.index;
    //     if (tabController.indexIsChanging) {
    //       String topicName =
    //           ['grammar', 'vocabulary', 'idioms'][tabController.index];
    //       homeBloc.add(TabChanged(topicName));
    //     }
    //   }

    //   tabController.addListener(onTabChanged);

    //   // This is crucial to ensure that we don't dispatch an event that's already been sent by the Bloc's constructor.
    //   // However, if the tab controller's index doesn't change right after initialization (stays at initial index), we might still need to force an update.
    //   if (!tabController.indexIsChanging) {
    //     String initialTopic =
    //         ['grammar', 'vocabulary', 'idioms'][tabController.index];
    //     homeBloc.add(TabChanged(initialTopic));
    //   }

    //   return () => tabController.removeListener(onTabChanged);
    // }, [
    //   tabController,
    //   homeBloc
    // ]); // Assuming homeBloc doesn't change, it might not need to be in the dependencies

    return Scaffold(
      appBar: genericAppBar(context, AppString.letslearn, false),
      body: SafeArea(
        child: SizedBox(
          height: 812.h,
          width: 375.w,
          child: Stack(
            children: <Widget>[
              TabBarView(
                controller: tabController,
                children: <Widget>[
                  AnimatedTab(topic: 'grammar', homeBloc: homeBloc),
                  AnimatedTab(topic: 'vocabulary', homeBloc: homeBloc),
                  AnimatedTab(topic: 'idioms', homeBloc: homeBloc),
                ],
              ),
              Material(
                color: Colors.transparent,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  child: TabBar(
                    controller: tabController,
                    padding: EdgeInsets.zero,
                    isScrollable: true,
                    tabs: [
                      CustomTab(
                          label: 'Grammar', isActive: currentIndex.value == 0),
                      CustomTab(
                          label: 'Vocabulary',
                          isActive: currentIndex.value == 1),
                      CustomTab(
                          label: 'Idioms', isActive: currentIndex.value == 2),
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
}
