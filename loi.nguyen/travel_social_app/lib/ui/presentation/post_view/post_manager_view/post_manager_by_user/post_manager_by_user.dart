import 'package:flutter/material.dart';
import 'package:travel_social_app/core/model/post_model.dart';
import 'package:travel_social_app/ui/presentation/post_view/post_manager_view/components/post_manager_list.dart';
import 'package:travel_social_app/ui/base/base_view.dart';
import 'package:travel_social_app/ui/presentation/post_view/post_manager_view/post_manager_by_user/controller/post_manager_by_user_controller.dart';

class PostMangerByUser extends StatefulWidget {
  const PostMangerByUser({super.key});

  @override
  State<PostMangerByUser> createState() => _PostMangerByUserState();
}

class _PostMangerByUserState extends State<PostMangerByUser>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _PostMangerByUserT();
  }
}

class _PostMangerByUserT extends BaseView<PostManagerByUserController> {
  _PostMangerByUserT() : super(PostManagerByUserController(), isScreen: false);

  @override
  Widget getMainView(
      BuildContext context, PostManagerByUserController controller) {
    List<PostModel> list = controller.list;
    return PostManagerList(list: list);
  }
}
