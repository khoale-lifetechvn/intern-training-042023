import 'package:flutter/material.dart';
import 'package:travel_social_app/core/model/post_model.dart';
import 'package:travel_social_app/ui/base_widget/form_data.dart';

import 'package:travel_social_app/ui/base_widget/lf_appbar.dart';
import 'package:travel_social_app/ui/base_widget/lf_form_picker.dart';
import 'package:travel_social_app/ui/base_widget/lf_text_field.dart';
import 'package:travel_social_app/ui/presentation/manager_post_view/controller/manager_post_controller.dart';

class ManagerPostView extends StatelessWidget {
  final PostModel? postModel;
  ManagerPostView({
    Key? key,
    this.postModel,
  }) : super(key: key);

  bool get isUpdate => postModel != null;

  final ManagerPostController controller = ManagerPostController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: LFAppBar(title: isUpdate ? 'Update post' : 'Add post'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                FormData(
                  onSubmit: () => isUpdate
                      ? controller.updatePost(postModel!.id)
                      : controller.addPost(),
                  onDelete: isUpdate
                      ? () => controller.deletePost(postModel!.id)
                      : null,
                  list: listTextField,
                  disable: false,
                  isFullScreen: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> get listTextField => [
        LFFormPicker(
          onSaved: (p0) => controller.file = p0,
          urlInit: postModel?.img,
        ),
        LFTextFormField(
          label: 'Title',
          onSaved: (p0) => controller.title = p0,
          initValue: postModel?.title,
        ),
        LFTextFormField(
          label: 'Content',
          maxLines: null,
          onSaved: (p0) => controller.content = p0,
          initValue: postModel?.content,
        ),
      ];
}
