import 'package:flutter/material.dart';
import 'package:task_firebase/core/model/user_model.dart';
import 'package:task_firebase/ui/base/base_view.dart';
import 'package:task_firebase/ui/base_widget/lf_appbar.dart';
import 'package:task_firebase/ui/presentation/find_users_view/detail_user_follow_view/controller/detail_user_follow_controller..dart';
import 'package:task_firebase/ui/presentation/find_users_view/detail_user_follow_view/list_posts_user/list_posts_user.dart';
import 'package:task_firebase/ui/resources/color_manager.dart';
import 'package:task_firebase/ui/resources/styles_manager.dart';

class DetailUserFollowView extends BaseView<DetailUserFollowController> {
  DetailUserFollowView({super.key, required this.user})
      : super(DetailUserFollowController(user.id));
  final UserModel user;

  @override
  AppBar? appBar(BuildContext context) {
    return LFAppBar(title: 'Detail Author');
  }

  @override
  Widget getEmtpyView() {
    controller.clearData();
    return infoAuthor();
  }

  @override
  Widget getMainView(
      BuildContext context, DetailUserFollowController controller) {
    return infoAuthor();
  }

  Widget infoAuthor() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.network(
              user.img,
              height: 250,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  user.showName,
                  style: getTitleText(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              IconButton(
                onPressed: () {
                  controller.updateFollow();
                },
                icon: controller.isFollow
                    ? Icon(
                        Icons.favorite,
                        color: ColorManager.red,
                      )
                    : const Icon(Icons.favorite_border),
              )
            ],
          ),
          const SizedBox(height: 8),
          Text(
            user.email,
            style: getLabelText(color: ColorManager.greyBG),
          ),
          Divider(
            color: ColorManager.greyTF,
            height: 16,
          ),
          infoFollow(),
          Divider(
            color: ColorManager.greyTF,
            height: 16,
          ),
          Expanded(
            child: ListPostsUser(
              userID: user.id,
            ),
          )
        ],
      ),
    );
  }

  Widget infoFollow() {
    return Column(
      children: [
        Text('Number follow: ${controller.listIdUserFollow.length}'),
        const SizedBox(height: 16),
      ],
    );
  }
}
