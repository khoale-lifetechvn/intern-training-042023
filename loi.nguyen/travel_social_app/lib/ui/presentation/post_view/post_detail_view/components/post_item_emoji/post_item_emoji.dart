import 'package:flutter/material.dart';
import 'package:travel_social_app/core/model/reaction_model.dart';
import 'package:travel_social_app/core/service/get_navigation.dart';
import 'package:travel_social_app/locator.dart';
import 'package:travel_social_app/ui/base/base_view.dart';
import 'package:travel_social_app/ui/base_widget/base_skeleton.dart';
import 'package:travel_social_app/ui/presentation/post_view/post_detail_view/components/post_item_emoji/controller/post_item_emoji_controller.dart';
import 'package:travel_social_app/ui/resources/color_manager.dart';
import 'package:travel_social_app/ui/resources/styles_manager.dart';

class PostItemEmoji extends BaseView<PostItemEmojiController> {
  PostItemEmoji({super.key, required String postID})
      : super(PostItemEmojiController(postID: postID),
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
      BuildContext context, PostItemEmojiController controller) {
    return const BaseSkeleton(content: 'Loading...');
  }

  @override
  Widget getMainView(BuildContext context, PostItemEmojiController controller) {
    return itemEmoji();
  }

  Widget itemEmoji() {
    List<ReactionModel> listEmojiPost = controller.listEmojiPost;
    return InkWell(
      onTap: onTapReaction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          controller.currentEmoji == null
              ? Text(
                  'Reaction',
                  style: getLabelText(color: ColorManager.blue),
                )
              : Image.network(
                  controller.currentEmoji!.img,
                  width: 30,
                  height: 30,
                ),
          const SizedBox(height: 8),
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
