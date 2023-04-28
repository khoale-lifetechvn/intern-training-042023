import 'package:flutter/material.dart';
import 'package:task_firebase/core/model/emoji_model.dart';
import 'package:task_firebase/core/model/reaction_model.dart';
import 'package:task_firebase/core/service/singleton.dart';
import 'package:task_firebase/locator.dart';
import 'package:task_firebase/ui/base/base_view.dart';
import 'package:task_firebase/ui/presentation/post_view/post_detail_view/components/comment_item/component/controller/emoji_comment_controller.dart';
import 'package:task_firebase/ui/resources/assets_manager.dart';
import 'package:task_firebase/ui/resources/color_manager.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:task_firebase/ui/resources/styles_manager.dart';

class EmojiComment extends StatefulWidget {
  const EmojiComment({super.key, required this.commentId});
  final String commentId;

  @override
  State<EmojiComment> createState() => _EmojiCommentState();
}

class _EmojiCommentState extends State<EmojiComment>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _EmojiCommentT(commentId: widget.commentId);
  }

  @override
  bool get wantKeepAlive => true;
}

class _EmojiCommentT extends BaseView<EmojiCommentController> {
  _EmojiCommentT({required String commentId})
      : super(EmojiCommentController(commentID: commentId), isScreen: false);

  @override
  Widget getMainView(BuildContext context, EmojiCommentController controller) {
    return info();
  }

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

  @override
  Widget getEmtpyView() {
    // logError(controller.currentEmoji == null
    //     ? 'Empty'
    //     : controller.currentEmoji!.data.toString());
    return info();
  }

  @override
  Widget getSkeletonView(
      BuildContext context, EmojiCommentController controller) {
    return const CircularProgressIndicator();
  }
}
