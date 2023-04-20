import 'package:flutter/material.dart';

import 'package:task_firebase/ui/base_widget/form_data.dart';
import 'package:task_firebase/ui/base_widget/lf_appbar.dart';
import 'package:task_firebase/ui/base_widget/lf_text_field.dart';
import 'package:task_firebase/ui/presentation/user_view/user_detail_view/controller/user_detail_controller.dart';

class UserDetailView extends StatelessWidget {
  UserDetailView({
    Key? key,
  }) : super(key: key);
  final UserDetailController controller = UserDetailController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: LFAppBar(title: 'Modify User'),
      body: FormData(
        onSubmit: () {
          controller.updateUser();
        },
        list: listTextField,
        isFullScreen: true,
      ),
    );
  }

  List<Widget> get listTextField => [
        LFTextFormField(
          label: 'Name',
          initValue: controller.user.name,
          onSaved: (p0) => controller.name = p0,
        ),
        LFTextFormField(
          label: 'Date of birth',
          initValue: controller.user.dbo,
          maxLines: null,
          onSaved: (p0) => controller.dbo = p0,
        ),
      ];
}
