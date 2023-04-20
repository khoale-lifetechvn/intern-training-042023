import 'package:flutter/material.dart';
import 'package:task_firebase/ui/presentation/post_view/base_main_view.dart';
import 'package:task_firebase/ui/presentation/post_view/post_add_view/controller/post_add_controller.dart';
import 'package:task_firebase/ui/base_widget/lf_text_field.dart';

class PostAddView extends BaseMainView {
  PostAddView({super.key});
  final PostAddController controller = PostAddController();

  @override
  String get titleAppbar => 'Add quizz';

  @override
  void onSubmitForm() {
    controller.addPost();
  }

  @override
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
}
