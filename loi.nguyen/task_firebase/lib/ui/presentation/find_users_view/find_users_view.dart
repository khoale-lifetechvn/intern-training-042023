import 'package:flutter/material.dart';
import 'package:task_firebase/ui/base/base_view.dart';
import 'package:task_firebase/ui/base_widget/lf_appbar.dart';
import 'package:task_firebase/ui/presentation/find_users_view/components/find_users_list.dart';
import 'package:task_firebase/ui/presentation/find_users_view/controllers/find_user_controller.dart';

class FindUsersView extends BaseView<FindUserViewController> {
  FindUsersView({super.key}) : super(FindUserViewController());

  @override
  Widget getMainView(BuildContext context, FindUserViewController controller) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: FindUserList(list: controller.listUser),
      ),
    );
  }

  @override
  AppBar? appBar(BuildContext context) {
    return LFAppBar(title: 'Find users');
  }
}
