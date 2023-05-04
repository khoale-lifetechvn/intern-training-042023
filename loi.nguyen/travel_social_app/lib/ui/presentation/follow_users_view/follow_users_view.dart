import 'package:flutter/material.dart';
import 'package:travel_social_app/core/extension/extension.dart';
import 'package:travel_social_app/core/model/user_model.dart';
import 'package:travel_social_app/ui/base_widget/base_skeleton.dart';
import 'package:travel_social_app/ui/base_widget/find_users_list.dart';
import 'package:travel_social_app/ui/base_widget/lf_appbar.dart';
import 'package:travel_social_app/ui/presentation/follow_users_view/controller/follow_users_controller.dart';

import 'package:travel_social_app/ui/resources/color_manager.dart';

class FollowUsersView extends StatelessWidget {
  final FollowUsersController controller = FollowUsersController();

  FollowUsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LFAppBar(title: 'Users Follow'),
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
                    controller.updateFollow(user.id);
                  },
                  icon: user.isFollowThisAccount
                      ? Icon(
                          Icons.favorite,
                          color: ColorManager.red,
                        )
                      : const Icon(Icons.favorite_border),
                );
              },
            );
          }
        },
      ),
    );
  }
}
