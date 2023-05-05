import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_social_app/core/model/base_table.dart';
import 'package:travel_social_app/core/extension/extension.dart';
import 'package:travel_social_app/core/service/api_nosql.dart';
import 'package:travel_social_app/ui/presentation/news_feed_view/components/posts_list/component/post_comment_item/comment_item/comment_list.dart';
import 'package:travel_social_app/ui/resources/styles_manager.dart';

class PostsCommentItem extends StatefulWidget {
  const PostsCommentItem({super.key, required this.postId});
  final String postId;

  @override
  State<PostsCommentItem> createState() => _PostsCommentItemState();
}

class _PostsCommentItemState extends State<PostsCommentItem> {
  int numberComment = 0;

  bool isLoadFirst = true;

  late final ApiNosql _apiNosql = ApiNosql(
      parentTable: BaseTable.comments,
      parentID: widget.postId,
      childTable: BaseTable.postComments);

  Future<QuerySnapshot<Object?>?> loadData() {
    return _apiNosql.getDataCollection();
  }

  @override
  Widget build(BuildContext context) {
    return isLoadFirst
        ? FutureBuilder(
            future: loadData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Icon(Icons.comment_bank_outlined);
              } else if (snapshot.hasError) {
                return const Text('....');
              } else {
                List<Map<String, dynamic>> list = snapshot.data.toListMap();
                numberComment = list.length;
                isLoadFirst = false;
                return icon();
              }
            })
        : icon();
  }

  Widget icon() {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            elevation: 2,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16))),
            isScrollControlled: true,
            builder: (_) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: CommentList(postId: widget.postId));
            }).whenComplete(() {
          setState(() {
            isLoadFirst = true;
          });
        });
      },
      child: Row(
        children: [
          const Icon(Icons.comment_bank_outlined),
          const SizedBox(width: 4),
          Text(
            numberComment.toString(),
            style: getLabelText(),
          )
        ],
      ),
    );
  }
}
