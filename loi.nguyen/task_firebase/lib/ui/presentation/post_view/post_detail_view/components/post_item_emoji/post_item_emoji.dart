import 'package:flutter/material.dart';
import 'package:task_firebase/core/model/reaction_model.dart';
import 'package:task_firebase/core/service/get_navigation.dart';
import 'package:task_firebase/locator.dart';
import 'package:task_firebase/ui/base/base_view.dart';
import 'package:task_firebase/ui/base_widget/base_skeleton.dart';
import 'package:task_firebase/ui/presentation/post_view/post_detail_view/components/post_item_emoji/controller/post_item_emoji_controller.dart';
import 'package:task_firebase/ui/resources/color_manager.dart';
import 'package:task_firebase/ui/resources/styles_manager.dart';

class PostItemEmoji extends BaseView<PostItemEmojiController> {
  PostItemEmoji({super.key, required String postID})
      : super(PostItemEmojiController(postID: postID), isScreen: false);

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
    List<ReactionModel> listEmojiPost = controller.listEmojiPost;
    return controller.currentEmoji == null
        ? notReaction()
        : InkWell(
            onTap: onTapReaction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  controller.currentEmoji!.img,
                  width: 30,
                  height: 30,
                ),
                itemLabel(listEmojiPost.length.toString())
              ],
            ),
          );
  }

  Widget notReaction() {
    return TextButton(
      onPressed: onTapReaction,
      child: Text(
        'Reaction',
        style: getLabelText(color: ColorManager.blue),
      ),
    );
  }

  @override
  Widget getEmtpyView() {
    return notReaction();
  }

  Widget itemLabel(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(height: 8),
        Text(
          title,
          style: getLabelText(),
        ),
      ],
    );
  }
}
