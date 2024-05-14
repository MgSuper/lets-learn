import 'package:boost_e_skills/features/knowledge_content/bloc/knowledge_content_bloc.dart';
import 'package:boost_e_skills/features/knowledge_content/model/knowledge_content.dart';
import 'package:boost_e_skills/shared/utils/auth_utils.dart';
import 'package:boost_e_skills/shared/utils/resources/color_manager.dart';
import 'package:boost_e_skills/shared/utils/resources/value_manager.dart';
import 'package:boost_e_skills/shared/utils/shimmers/shimmer_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KnowledgeContentItem extends HookWidget {
  final KnowledgeContentModel content;

  const KnowledgeContentItem({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final currentUser = getCurrentUser();
    final isExpanded = useState(false);
    return Card(
      color: ColorManager.malibu,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.w),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(5.w),
                  ),
                  child: Text(
                    content.category,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: ColorManager.black,
                        ),
                  ),
                ),
                Text(
                  content.getRelativeTime(),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.w),
              child: ShimmerCachedNetworkImage(
                height: 180.h,
                width: double.infinity,
                imageUrl: content.imageUrl,
              ),
            ),
          ), // Ensure you handle loading and error states in real apps

          ListTile(
            title: Text(
              content.title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: ColorManager.black,
                    fontSize: AppSize.s18,
                  ),
            ),
            subtitle: GestureDetector(
              onTap: () {
                isExpanded.value = !isExpanded.value;
              },
              child: Text(
                content.description,
                maxLines: isExpanded.value ? null : 3,
                overflow: isExpanded.value
                    ? TextOverflow.visible
                    : TextOverflow.ellipsis,
              ),
            ),
            isThreeLine: true,
            subtitleTextStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: ColorManager.black),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.read<KnowledgeContentBloc>().add(
                            LikeContent(
                              contentId: content.id,
                              userId: currentUser!.uid,
                            ),
                          );
                    },
                    icon: Icon(
                      content.likedByUsers.contains(currentUser?.uid ?? '')
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color:
                          content.likedByUsers.contains(currentUser?.uid ?? '')
                              ? ColorManager.error
                              : ColorManager.black,
                    ),
                  ),
                  Text(
                    content.likedByUsers.length <= 1
                        ? '${content.likedByUsers.length} like'
                        : '${content.likedByUsers.length} likes',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: ColorManager.black,
                          fontSize: AppSize.s18,
                        ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.share_outlined,
                      ),
                    ),
                    Text(
                      'share',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: ColorManager.black,
                            fontSize: AppSize.s18,
                          ),
                    ),
                  ],
                ),
              ),
              // TextButton.icon(
              //   icon: Icon(Icons.comment),
              //   label: Text('${content.comments.length}'),
              //   onPressed: () {
              //     // Open a dialog or navigate to a comment page
              //   },
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
