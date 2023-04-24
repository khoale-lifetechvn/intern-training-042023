import 'package:flutter/material.dart';
import 'package:task_firebase/core/model/post_comment_model.dart';
import 'package:task_firebase/ui/presentation/post_view/post_detail_view/components/comment.dart';

class CommentList extends StatelessWidget {
  const CommentList({super.key, required this.listCommnent});
  final List<PostCommentModel> listCommnent;

  @override
  Widget build(BuildContext context) {
    return Column(
        // separator: Divider(
        //   color: ColorManager.greyBG,
        //   height: 8,
        //   indent: 1,
        // ),
        children:
            listCommnent.map((e) => Comment(postCommentModel: e)).toList());
  }
}
