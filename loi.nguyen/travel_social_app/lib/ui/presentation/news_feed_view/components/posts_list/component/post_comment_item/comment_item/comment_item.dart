import 'package:flutter/material.dart';
import 'package:travel_social_app/core/model/post_comment_model.dart';
import 'package:travel_social_app/core/service/singleton.dart';
import 'package:travel_social_app/locator.dart';
import 'package:travel_social_app/ui/base_widget/with_spacing.dart';
import 'package:travel_social_app/ui/presentation/news_feed_view/components/posts_list/component/post_comment_item/comment_item/component/emoji_comment.dart';
import 'package:travel_social_app/ui/resources/color_manager.dart';
import 'package:travel_social_app/ui/resources/styles_manager.dart';
import 'package:travel_social_app/core/extension/extension.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({super.key, required this.postCommentModel});
  final PostCommentModel postCommentModel;

  String get urlImg => postCommentModel.user.showImg;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: AspectRatio(
                aspectRatio: 0.9,
                child: Image.network(urlImg, fit: BoxFit.fitHeight)),
          ),
          Expanded(flex: 4, child: info()),
        ],
      ),
    );
  }

  Widget info() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ColumnWithSpacing(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          RowWithSpacing(
            spacing: 4,
            children: [
              Text(
                postCommentModel.user.showName,
                style: getTitle1Text(),
              ),
              Text(
                '-',
                style: getTitle1Text(),
              ),
              Text(postCommentModel.createdAtDate.toRelativeTime())
            ],
          ),
          Text(
            postCommentModel.content,
            style: getLabelText(color: ColorManager.greyBG),
          ),
          EmojiComment(commentId: postCommentModel.id)
        ],
      ),
    );
  }

  List<Reaction> get listReaction => locator<Singleton>()
      .listEmoji
      .map((e) => Reaction(
          icon: Image.network(e.img, width: 30, height: 30), value: e.id))
      .toList();
}
