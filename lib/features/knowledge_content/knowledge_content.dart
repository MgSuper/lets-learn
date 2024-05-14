import 'package:boost_e_skills/features/knowledge_content/bloc/knowledge_content_bloc.dart';
import 'package:boost_e_skills/features/knowledge_content/widgets/knowledge_content_item.dart';
import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/strings_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/styles_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KnowledgeContent extends HookWidget {
  const KnowledgeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final listKey = GlobalKey();

    final category = useState<String>('All');
    final scrollController = useScrollController();

    useEffect(() {
      // Function to handle the scroll event
      void onScroll() {
        if (scrollController.hasClients &&
            scrollController.position.pixels ==
                scrollController.position.maxScrollExtent) {
          // Load more content based on the category
          if (category.value == 'All') {
            context
                .read<KnowledgeContentBloc>()
                .add(FetchNextKnowledgeContents());
          } else {
            context
                .read<KnowledgeContentBloc>()
                .add(FetchNextContentsByCategory(category.value));
          }
        }
      }

      // Add the event listener
      scrollController.addListener(onScroll);

      // Return a cleanup function that will be called on unmount or dependency change
      return () {
        scrollController.removeListener(onScroll);
        // Use a post-frame callback to delay the disposal of the controller
        // solve this issue
        /**
         * The following assertion was thrown while disposing _Entry<HookState<Object?, Hook<Object?>>>:
           A ScrollController was used after being disposed.
           Once you have called dispose() on a ScrollController, it can no longer be used.
         */
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scrollController.hasClients) {
            scrollController.dispose();
          }
        });
      };
    }, [
      category.value
    ]); // Dependency array, useEffect will re-run if category.value changes

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          AppString.ksharing,
          style: getRegularStyle(
            color: ColorManager.white,
            fontSize: AppSize.s20,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: AppSize.s0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w, top: 5.h),
            child: DropdownButton<String>(
              value: category.value,
              iconEnabledColor: ColorManager.white,
              underline: Container(),
              dropdownColor: ColorManager.primary,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: ColorManager.white,
                  ),
              items: ['All', 'Fruits', 'NightLife']
                  .map((categoryName) => DropdownMenuItem(
                        value: categoryName,
                        child: Text(categoryName),
                      ))
                  .toList(),
              onChanged: (value) {
                category.value = value ?? 'All';
                if (category.value == 'All') {
                  context
                      .read<KnowledgeContentBloc>()
                      .add(const FetchKnowledgeContents());
                } else {
                  context
                      .read<KnowledgeContentBloc>()
                      .add(FetchContentsByCategory(category.value));
                }
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<KnowledgeContentBloc, KnowledgeContentState>(
              builder: (context, state) {
                if (state is KnowledgeContentLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is KnowledgeContentLoaded) {
                  return ListView.separated(
                    key: listKey,
                    controller: scrollController,
                    itemCount: state.kcontents.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 15.h),
                    itemBuilder: (context, index) {
                      if (index == state.kcontents.length) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return KnowledgeContentItem(
                          content: state.kcontents[index]);
                    },
                  );
                } else if (state is KnowledgeContentLoadError) {
                  return Center(child: Text('Error: ${state.err}'));
                }
                return const Center(child: Text('No content available.'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
