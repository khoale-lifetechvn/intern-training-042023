import 'package:flutter/material.dart';
import 'package:travel_social_app/core/model/reaction_model.dart';
import 'package:travel_social_app/core/service/get_navigation.dart';
import 'package:travel_social_app/locator.dart';
import 'package:travel_social_app/ui/base/base_view.dart';
import 'package:travel_social_app/ui/base_widget/base_skeleton.dart';
import 'package:travel_social_app/ui/presentation/news_feed_view/components/posts_list/component/post_emoji_item/controller/post_emoji_item_controller.dart';
import 'package:travel_social_app/ui/resources/styles_manager.dart';

class PostEmojiItem extends BaseView<PostEmojiItemController> {
  PostEmojiItem({super.key, required String postID})
      : super(PostEmojiItemController(postID: postID),
            isScreen: false, isDeclareController: true);

  void onTapReaction() {
    locator<GetNavigation>().openReaction(
        onChangeSubmit: (v) {
          controller.submitReaction(emojiId: v);
        },
        emojiId: controller.currentEmoji?.id);
  }

  @override
  Widget getSkeletonView(
      BuildContext context, PostEmojiItemController controller) {
    return const BaseSkeleton(content: 'Loading...');
  }

  @override
  Widget getMainView(BuildContext context, PostEmojiItemController controller) {
    return itemEmoji();
  }

  Widget itemEmoji() {
    List<ReactionModel> listEmojiPost = controller.listEmojiPost;
    return InkWell(
      onTap: onTapReaction,
      child: Row(
        children: [
          controller.currentEmoji == null
              ? const Icon(
                  Icons.favorite_border,
                )
              : Image.network(
                  controller.currentEmoji!.img,
                  width: 25,
                  height: 25,
                ),
          const SizedBox(width: 4),
          Text(
            listEmojiPost.length.toString(),
            style: getLabelText(),
          )
        ],
      ),
    );
  }

  @override
  Widget getEmtpyView() {
    controller.clearData();
    return itemEmoji();
  }
}
