import 'package:flutter/material.dart';
import 'package:task_firebase/core/extension/log.dart';
import 'package:task_firebase/core/model/user_model.dart';
import 'package:task_firebase/ui/base_widget/base_skeleton.dart';
import 'package:task_firebase/ui/base_widget/lf_appbar.dart';
import 'package:task_firebase/ui/presentation/find_users_view/components/find_users_list.dart';
import 'package:task_firebase/ui/presentation/find_users_view/controller/find_users_controller.dart';

class FindUsersView extends StatefulWidget {
  const FindUsersView({super.key});
  @override
  State<FindUsersView> createState() => _FindUsersViewState();
}

class _FindUsersViewState extends State<FindUsersView> {
  FindUsersController controller = FindUsersController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LFAppBar(title: 'Find Users'),
      body: StreamBuilder(
        stream: controller.streamData(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const BaseSkeleton(content: 'Loading...');
          } else if (snapshot.hasError) {
            return const BaseSkeleton(content: 'Errror...');
          } else {
            if (snapshot.data!.isEmpty) {
              return const BaseSkeleton(content: 'Empty data...');
            }
            List<UserModel> listUser =
                snapshot.data!.map((e) => UserModel(e)).toList();
            return FindUserList(
              list: listUser,
            );
          }
        },
      ),
    );
  }
}
