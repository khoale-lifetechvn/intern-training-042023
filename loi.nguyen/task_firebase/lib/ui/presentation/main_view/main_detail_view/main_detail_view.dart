import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_firebase/core/model/post_model.dart';
import 'package:task_firebase/core/model/user_model.dart';
import 'package:task_firebase/ui/base_widget/with_spacing.dart';
import 'package:task_firebase/ui/presentation/main_view/base_main_view.dart';
import 'package:task_firebase/ui/presentation/main_view/main_detail_view/controller/main_detail_controller.dart';
import 'package:task_firebase/ui/base_widget/lf_text_field.dart';
import 'package:task_firebase/core/extension/extension.dart';
import 'package:task_firebase/ui/resources/styles_manager.dart';

class MainDetailView extends BaseMainView {
  MainDetailView({super.key, required this.model}) {
    controller = MainDetailController(model);
  }
  final PostModel model;
  late final MainDetailController controller;
  late final UserModel user;

  @override
  String get titleAppbar => 'Dettail quizz';

  @override
  void onSubmitForm() {
    controller.updatePost();
  }

  @override
  Widget infoWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: FutureBuilder<DocumentSnapshot<Object?>>(
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
                  Text('Updated At: ${model.updatedAt}', style: getLabelText())
                ],
              );
            }
          }),
    );
  }

  @override
  List<Widget> get listTextField => [
        LFTextFormField(
          label: 'Title',
          initValue: model.title,
          onSaved: (p0) => controller.title = p0,
          disable: controller.isAuthor == false,
        ),
        LFTextFormField(
          label: 'Content',
          initValue: model.content,
          disable: controller.isAuthor == false,
          maxLines: null,
          onSaved: (p0) => controller.content = p0,
        ),
      ];
}
