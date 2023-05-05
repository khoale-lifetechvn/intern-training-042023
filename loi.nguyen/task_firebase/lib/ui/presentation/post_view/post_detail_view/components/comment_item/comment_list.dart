import 'package:flutter/material.dart';
import 'package:task_firebase/core/model/post_comment_model.dart';
import 'package:task_firebase/ui/presentation/post_view/post_detail_view/components/comment_item/comment_item.dart';

class CommentList extends StatelessWidget {
  const CommentList({super.key, required this.listCommnent});
  final List<PostCommentModel> listCommnent;

  @override
  Widget build(BuildContext context) {
    return Column(
        children:
            listCommnent.map((e) => CommentItem(postCommentModel: e)).toList());
  }

}