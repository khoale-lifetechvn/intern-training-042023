import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_firebase/core/model/post_comment_model.dart';
import 'package:task_firebase/core/model/post_model.dart';
import 'package:task_firebase/core/model/user_model.dart';
import 'package:task_firebase/ui/base_widget/base_skeleton.dart';
import 'package:task_firebase/ui/base_widget/form_data.dart';
import 'package:task_firebase/ui/base_widget/with_spacing.dart';
import 'package:task_firebase/ui/presentation/post_view/base_post_view.dart';
import 'package:task_firebase/ui/presentation/post_view/post_detail_view/components/comment_list.dart';
import 'package:task_firebase/ui/presentation/post_view/post_detail_view/components/text_field_comment.dart';
import 'package:task_firebase/ui/presentation/post_view/post_detail_view/controller/post_detail_controller.dart';
import 'package:task_firebase/ui/base_widget/lf_text_field.dart';
import 'package:task_firebase/core/extension/extension.dart';
import 'package:task_firebase/ui/resources/color_manager.dart';
import 'package:task_firebase/ui/resources/styles_manager.dart';

class PostDetailView extends BasePostView {
  PostDetailView({super.key, required this.model}) {
    controller = PostDetailController(model);
  }
  final PostModel model;
  late final PostDetailController controller;
  late final UserModel user;

  @override
  String get titleAppbar => 'Dettail quizz';

  Widget infoWidget() {
    return FutureBuilder<DocumentSnapshot<Object?>>(
        future: controller.loadData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return const Text('No data');
          } else {
            user = UserModel(snapshot.data!.toMap());
            String username =
                controller.isAuthor ? '${user.name} (Myself)' : user.name;
            return ColumnWithSpacing(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Author: $username',
                  style: getLabelText(),
                ),
                Text('Email: ${user.email}', style: getLabelText()),
                Text('Created At: ${model.createdAt}', style: getLabelText()),
                Text('Updated At: ${model.updatedAt}', style: getLabelText()),
              ],
            );
          }
        });
  }

  List<Widget> get listTextField => [
        LFTextFormField(
          label: 'Title',
          initValue: model.title,
          onSaved: (p0) => controller.title = p0,
        ),
        LFTextFormField(
          label: 'Content',
          initValue: model.content,
          disable: controller.isAuthor == false,
          maxLines: null,
        ),
      ];

  @override
  Widget get body => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Information',
            style: getTitleText(),
          ),
          const SizedBox(height: 24),
          infoWidget(),
          const SizedBox(height: 32),
          controller.isAuthor
              ? FormData(
                  onSubmit: () {
                    controller.updatePost();
                  },
                  list: listTextField,
                  onDelete: () => controller.deletePost(),
                )
              : content(),
        ],
      );

  Widget content() {
    return Column(
      children: [
        Divider(color: ColorManager.black, height: 0.4),
        const SizedBox(height: 16),
        Text(
          'Title: ${model.title}',
          style: getTitleText(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          model.title,
          style: getLabelText(),
        ),
        Divider(color: ColorManager.black, height: 0.4),
        const SizedBox(height: 16),
        comment()
      ],
    );
  }

  @override
  Widget? get bottomSheet => TextFieldComment(onSubmit: (text) {
        controller.postCommnet(text);
      });

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
                  style: getTitleText(),
                ),
              );
            }
            controller.setDataComment(data);
            List<PostCommentModel> list = controller.listComment;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Comment ${list.length}'),
                const SizedBox(height: 16),
                CommentList(listCommnent: list)
              ],
            );
          }
        });
  }
}
