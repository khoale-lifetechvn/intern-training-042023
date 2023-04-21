import 'package:flutter/material.dart';
import 'package:task_firebase/ui/base_widget/form_data.dart';
import 'package:task_firebase/ui/presentation/post_view/base_post_view.dart';
import 'package:task_firebase/ui/presentation/post_view/post_add_view/controller/post_add_controller.dart';
import 'package:task_firebase/ui/base_widget/lf_text_field.dart';

class PostAddView extends BasePostView {
  PostAddView({super.key});
  final PostAddController controller = PostAddController();

  @override
  String get titleAppbar => 'Add Post';

  List<Widget> get listTextField => [
        LFTextFormField(
          label: 'Title',
          onSaved: (p0) => controller.title = p0,
        ),
        LFTextFormField(
          label: 'Content',
          maxLines: null,
          onSaved: (p0) => controller.content = p0,
        ),
      ];

  @override
  Widget get body => Column(
        children: [
          FormData(
            onSubmit: () => controller.addPost(),
            list: listTextField,
            disable: false,
            isFullScreen: true,
          ),
        ],
      );
}
