import 'package:flutter/material.dart';
import 'package:task_firebase/core/model/post_model.dart';
import 'package:task_firebase/ui/base_widget/form_data.dart';
import 'package:task_firebase/ui/base_widget/lf_text_field.dart';
import 'package:task_firebase/ui/presentation/post_view/base_post_view.dart';
import 'package:task_firebase/ui/presentation/post_view/post_detail_view/controller/post_detail_controller.dart';

class PostDetailEdit extends BasePostView {
  PostDetailEdit({super.key, required this.postModel}) {
    controller = PostDetailController(postModel);
  }
  final PostModel postModel;
  late final PostDetailController controller;

  @override
  Widget get body => FormData(
        onSubmit: () {
          controller.updatePost();
        },
        list: listTextField,
        onDelete: () => controller.deletePost(),
      );

  @override
  String get titleAppbar => 'Detail post';

  List<Widget> get listTextField => [
        LFTextFormField(
          label: 'Title',
          initValue: postModel.title,
          onSaved: (p0) => controller.title = p0,
        ),
        LFTextFormField(
          label: 'Content',
          initValue: postModel.content,
          maxLines: null,
          onSaved: (p0) => controller.content = p0,
        ),
        Text('Created at: ${postModel.createdAt}'),
        Text('Updated at: ${postModel.updatedAt}'),
      ];
}
