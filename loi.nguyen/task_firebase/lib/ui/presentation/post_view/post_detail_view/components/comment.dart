import 'package:flutter/material.dart';
import 'package:task_firebase/core/model/post_comment_model.dart';
import 'package:task_firebase/ui/base_widget/with_spacing.dart';
import 'package:task_firebase/ui/resources/color_manager.dart';
import 'package:task_firebase/ui/resources/styles_manager.dart';
import 'package:task_firebase/core/extension/extension.dart';

class Comment extends StatelessWidget {
  const Comment({super.key, required this.postCommentModel});
  final PostCommentModel postCommentModel;

  String get urlImg => postCommentModel.user.img.isEmpty
      ? 'https://media.dolenglish.vn/PUBLIC/MEDIA/6b64b08b-f03a-4ece-8b59-103819646301.jpg'
      : postCommentModel.user.img;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: AspectRatio(
                aspectRatio: 0.9,
                child: Image.network(postCommentModel.user.img,
                    fit: BoxFit.fitHeight)),
          ),
          Expanded(flex: 4, child: info())
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
                style: getTitleText(),
              ),
              Text(
                '-',
                style: getTitleText(),
              ),
              Text(postCommentModel.createdAtDate.toRelativeTime())
            ],
          ),
          Text(
            postCommentModel.content,
            style: getLabelText(color: ColorManager.greyBG),
          )
        ],
      ),
    );
  }
}
