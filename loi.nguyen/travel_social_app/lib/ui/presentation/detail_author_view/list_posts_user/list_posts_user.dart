import 'package:flutter/material.dart';
import 'package:travel_social_app/core/model/post_model.dart';
import 'package:travel_social_app/core/service/get_navigation.dart';
import 'package:travel_social_app/locator.dart';
import 'package:travel_social_app/ui/base/base_view.dart';
import 'package:travel_social_app/ui/presentation/detail_author_view/list_posts_user/controller/list_post_user_controller.dart';
import 'package:travel_social_app/ui/resources/color_manager.dart';
import 'package:travel_social_app/ui/resources/routes_manager.dart';
import 'package:travel_social_app/ui/resources/styles_manager.dart';

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
        locator<GetNavigation>().to(RouterPath.postDetail, arguments: model);
      },
      title: Text(model.title, style: getTitle1Text()),
      subtitle: Text(model.content,
          style: getLabelText(), maxLines: 1, overflow: TextOverflow.ellipsis),
    );
  }
}
