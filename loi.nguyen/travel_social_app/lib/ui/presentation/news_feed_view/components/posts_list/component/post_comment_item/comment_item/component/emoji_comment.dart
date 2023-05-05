import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_social_app/core/extension/log.dart';
import 'package:travel_social_app/core/model/emoji_model.dart';
import 'package:travel_social_app/core/model/reaction_model.dart';
import 'package:travel_social_app/core/service/singleton.dart';
import 'package:travel_social_app/locator.dart';
import 'package:travel_social_app/ui/presentation/news_feed_view/components/posts_list/component/post_comment_item/comment_item/component/controller/emoji_comment_controller.dart';
import 'package:travel_social_app/ui/resources/assets_manager.dart';
import 'package:travel_social_app/ui/resources/color_manager.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:travel_social_app/ui/resources/styles_manager.dart';

class EmojiComment extends StatelessWidget {
  EmojiComment({super.key, required String commentId}) {
    controller = EmojiCommentController(commentID: commentId);
  }

  late final EmojiCommentController controller;

  Widget info() {
    List<ReactionModel> list = controller.listEmojiComment;
    return Row(
      children: [
        ReactionButton(
            initialReaction: defaultReaction(),
            boxPadding: const EdgeInsets.all(8),
            boxColor: ColorManager.greyTF,
            boxOffset: const Offset(10, 10),
            onReactionChanged: (v) {
              controller.submitReactionComment(emojiId: v);
            },
            reactions: listReaction),
        const SizedBox(width: 8),
        Text(
          list.length.toString(),
          style: getLabelText(),
        )
      ],
    );
  }

  Reaction defaultReaction() {
    EmojiModel? emoji = controller.currentEmoji;
    return emoji == null
        ? Reaction(
            icon: Image.asset(ImageAssets.like, width: 30, height: 30),
            value: 'null')
        : icon(url: emoji.img, value: emoji.id);
  }

  List<Reaction> get listReaction => locator<Singleton>()
      .listEmoji
      .map((e) => icon(url: e.img, value: e.id))
      .toList();

  Reaction icon({required String url, required String value}) {
    return Reaction(
        icon: Image.network(url, width: 30, height: 30), value: value);
  }

  Widget getEmtpyView() {
    return info();
  }

  Widget getSkeletonView(
      BuildContext context, EmojiCommentController controller) {
    return const CircularProgressIndicator();
  }

  bool isLoadFirst = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: controller.loadDataStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return isLoadFirst ? getSkeletonView(context, controller) : info();
          } else if (snapshot.hasError) {
            logError('Có lỗi xãy ra ${snapshot.error}');
            return getSkeletonView(context, controller);
          } else {
            QuerySnapshot<Object?>? data = snapshot.data;
            controller.setData(data);
            if (data!.docs.isEmpty) {
              return getEmtpyView();
            }

            return info();
          }
        });
  }
}
