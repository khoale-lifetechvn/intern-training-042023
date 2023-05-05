import 'package:flutter/material.dart';
import 'package:travel_social_app/core/model/port_user_model.dart';
import 'package:travel_social_app/ui/base/base_view.dart';
import 'package:travel_social_app/ui/presentation/news_feed_view/components/posts_list/component/post_item.dart';
import 'package:travel_social_app/ui/presentation/news_feed_view/components/posts_list/controller/posts_list_controller.dart';
import 'package:travel_social_app/ui/base_widget/with_spacing.dart';

class PostsList extends BaseView<PostsListController> {
  PostsList({super.key}) : super(PostsListController(), isScreen: false);

  @override
  Widget getMainView(BuildContext context, PostsListController controller) {
    List<PostUserModel> listPosts = controller.listPostUser;
    return ColumnWithSpacing(
      children: listPosts.map((e) => PostItem(postUser: e)).toList(),
    );
  }
}
