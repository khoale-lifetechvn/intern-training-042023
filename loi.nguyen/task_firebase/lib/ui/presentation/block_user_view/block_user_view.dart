import 'package:flutter/material.dart';
import 'package:task_firebase/core/extension/extension.dart';
import 'package:task_firebase/core/model/user_model.dart';
import 'package:task_firebase/ui/base_widget/base_skeleton.dart';
import 'package:task_firebase/ui/base_widget/find_users_list.dart';
import 'package:task_firebase/ui/base_widget/lf_appbar.dart';
import 'package:task_firebase/ui/presentation/block_user_view/controller/block_user_controller.dart';
import 'package:task_firebase/ui/resources/color_manager.dart';

class BlockUserView extends StatelessWidget {
  final BlockUserController controller = BlockUserController();

  BlockUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LFAppBar(title: 'Block Users'),
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
            List<UserModel> listUser = snapshot.data!
                .map((e) => UserModel(e))
                .toList()
                .skipThisAccount();
            return FindUserList(
              list: listUser,
              trailingItem: (user) {
                return IconButton(
                  onPressed: () {
                    controller.updateBlock(user.id);
                  },
                  icon: user.isBlock
                      ? Icon(
                          Icons.block,
                          color: ColorManager.red,
                        )
                      : const Icon(Icons.block_sharp),
                );
              },
            );
          }
        },
      ),
    );
  }
}
