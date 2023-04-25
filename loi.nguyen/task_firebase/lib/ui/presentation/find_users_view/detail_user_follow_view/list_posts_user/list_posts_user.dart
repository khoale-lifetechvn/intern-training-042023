import 'package:flutter/material.dart';
import 'package:task_firebase/core/model/post_model.dart';
import 'package:task_firebase/core/service/get_navigation.dart';
import 'package:task_firebase/locator.dart';
import 'package:task_firebase/ui/base/base_view.dart';
import 'package:task_firebase/ui/presentation/find_users_view/detail_user_follow_view/list_posts_user/controller/list_post_user_controller.dart';
import 'package:task_firebase/ui/resources/color_manager.dart';
import 'package:task_firebase/ui/resources/routes_manager.dart';
import 'package:task_firebase/ui/resources/styles_manager.dart';

class ListPostsUser extends BaseView<ListPostUserController> {
  ListPostsUser({super.key, required String userID})
      : super(ListPostUserController(userID), isScreen: false);
  @override
  Widget getMainView(BuildContext context, ListPostUserController controller) {
    return ListView.separated(
        itemCount: controller.listPosts.length,
        separatorBuilder: (_, index) =>
            Divider(color: ColorManager.greyBG, height: 16, thickness: 0.4),
        itemBuilder: (_, index) => cardItem(controller.listPosts[index]));
  }

  Widget cardItem(PostModel model) {
    return ListTile(
      onTap: () {
        locator<GetNavigation>().to(RouterPath.postDetail, arguments: model.id);
      },
      title: Text(model.title, style: getTitleText()),
      subtitle: Text(model.content,
          style: getLabelText(), maxLines: 1, overflow: TextOverflow.ellipsis),
    );
  }
}
