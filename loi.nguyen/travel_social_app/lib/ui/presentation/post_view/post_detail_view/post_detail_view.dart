import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_social_app/core/model/post_comment_model.dart';
import 'package:travel_social_app/core/model/post_model.dart';
import 'package:travel_social_app/core/model/user_model.dart';
import 'package:travel_social_app/ui/base_widget/base_skeleton.dart';
import 'package:travel_social_app/ui/base_widget/lf_appbar.dart';
import 'package:travel_social_app/ui/presentation/block_user_view/default_block_view.dart';
import 'package:travel_social_app/ui/presentation/post_view/post_detail_view/components/text_field_comment.dart';
import 'package:travel_social_app/ui/presentation/post_view/post_detail_view/controller/post_detail_controller.dart';
import 'package:travel_social_app/ui/resources/color_manager.dart';
import 'package:travel_social_app/ui/resources/styles_manager.dart';

class PostDetailView extends StatelessWidget {
  PostDetailView({super.key, required this.model}) {
    controller = PostDetailController(model);
  }
  final PostModel model;
  late final PostDetailController controller;
  late final UserModel user;

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }

  Widget someonePost(BuildContext context) {
    return model.isBlockThisAccount
        ? const DefaultBlockView()
        : GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              appBar: LFAppBar(title: 'Detail Post'),
              body: ListView(
                children: [
                  image(context),
                  Divider(color: ColorManager.greyBG, thickness: 0.3),
                  content(),
                  Divider(color: ColorManager.greyBG, thickness: 0.3),
                  comment(),
                ],
              ),
              bottomSheet: TextFieldComment(onSubmit: (text) {
                controller.postCommnet(text);
              }),
            ),
          );
  }

  Widget content() {
    String title = '${model.title}( ${controller.userPost.name} )';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: getTitle1Text(),
                ),
                const SizedBox(height: 8),
                Text(
                  'Updated At: ${model.updatedAt}',
                  style: getLabelText(),
                ),
                //Desc
                const SizedBox(height: 16),
                Text(
                  model.content,
                  style: getLabelText(color: ColorManager.greyForm),
                )
              ],
            ),
          ),
          // PostItemEmoji(postID: model.id)
        ],
      ),
    );
  }

  Widget image(BuildContext context) {
    return Image.network(
        'https://xuyenvietmedia.com/wp-content/uploads/2022/11/Topic-la-gi-1.jpg',
        height: 200);
  }

  Widget comment() {
    return StreamBuilder(
        stream: controller.streamComment(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const BaseSkeleton(content: 'Loading comment...');
          } else if (snapshot.hasError) {
            return const BaseSkeleton(content: 'Error when load comment');
          } else {
            QuerySnapshot<Object?>? data = snapshot.data;

            if (data!.docs.isEmpty) {
              return Center(
                child: Text(
                  'No comment',
                  style: getTitle1Text(),
                ),
              );
            }
            controller.setDataComment(data);
            List<PostCommentModel> list = controller.listComment;

            return Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Comment ${list.length}'),
                  const SizedBox(height: 16),
                  // CommentList(listCommnent: list)
                ],
              ),
            );
          }
        });
  }
}