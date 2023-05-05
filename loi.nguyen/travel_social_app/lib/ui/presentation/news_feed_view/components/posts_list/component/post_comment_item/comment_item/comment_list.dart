import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_social_app/core/extension/extension.dart';
import 'package:travel_social_app/core/extension/methods.dart';
import 'package:travel_social_app/core/model/base_table.dart';
import 'package:travel_social_app/core/model/field_name.dart';
import 'package:travel_social_app/core/model/post_comment_model.dart';
import 'package:travel_social_app/core/service/api_nosql.dart';
import 'package:travel_social_app/core/service/get_navigation.dart';
import 'package:travel_social_app/core/service/singleton.dart';
import 'package:travel_social_app/locator.dart';
import 'package:travel_social_app/ui/base_widget/base_skeleton.dart';
import 'package:travel_social_app/ui/base_widget/lf_dialog.dart';
import 'package:travel_social_app/ui/presentation/news_feed_view/components/posts_list/component/post_comment_item/comment_item/comment_item.dart';
import 'package:travel_social_app/ui/presentation/post_view/post_detail_view/components/text_field_comment.dart';
import 'package:travel_social_app/ui/resources/color_manager.dart';

class CommentList extends StatefulWidget {
  const CommentList({super.key, required this.postId});
  final String postId;

  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  late Stream<QuerySnapshot<Object?>?> _commentStream;

  @override
  void initState() {
    super.initState();
    _commentStream = _apiNosqlComment.ref
        .orderBy(FieldName.createdAt, descending: true)
        .snapshots();
  }

  late final ApiNosql _apiNosqlComment = ApiNosql(
      parentTable: BaseTable.comments,
      parentID: widget.postId,
      childTable: BaseTable.postComments);

  void postCommnet(String comment) {
    _apiNosqlComment.addData(data: {
      FieldName.userRef: locator<Singleton>().userModel.id,
      FieldName.content: comment
    }).then((value) {
      if (value == null) {
        locator<GetNavigation>().openDialog(
            content: 'Post successfully ^^', typeDialog: TypeDialog.sucesss);
      } else {
        locator<GetNavigation>().openDialog(content: 'Error post $value');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _commentStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const BaseSkeleton(content: 'Loading...');
          } else if (snapshot.hasError) {
            return const BaseSkeleton(content: 'Error');
          } else {
            List<PostCommentModel> list = listCommentUser(snapshot.data);

            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('This post has no comments yet'),
              );
            }
            return Column(
              children: [
                TextFieldComment(onSubmit: postCommnet),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.separated(
                    itemCount: list.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    separatorBuilder: (_, index) => Divider(
                      height: 16,
                      thickness: 0.3,
                      color: ColorManager.greyBG,
                    ),
                    itemBuilder: (_, index) =>
                        CommentItem(postCommentModel: list[index]),
                  ),
                )
              ],
            );
          }
        });
  }

  List<PostCommentModel> listCommentUser(QuerySnapshot<Object?>? data) {
    List<Map<String, dynamic>> temp = [];
    for (var eComment in data.toListMapCustom()) {
      for (var eUser in locator<Singleton>().listUser) {
        if (Methods.getString(eComment, FieldName.userRef) == eUser.id) {
          eComment[BaseTable.users] = eUser.data;
          temp.add(eComment);
          break;
        }
      }
    }
    return temp.map((e) => PostCommentModel(e)).toList();
  }
}
