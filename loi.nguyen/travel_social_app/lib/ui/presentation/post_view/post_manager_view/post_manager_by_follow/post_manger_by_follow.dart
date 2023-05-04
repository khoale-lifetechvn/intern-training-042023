import 'package:flutter/material.dart';
import 'package:travel_social_app/ui/base/base_view.dart';
import 'package:travel_social_app/ui/presentation/post_view/post_manager_view/components/post_manager_list.dart';
import 'package:travel_social_app/ui/presentation/post_view/post_manager_view/post_manager_by_follow/controller/post_manager_by_follow_controller.dart';

class PostMangerByFollow extends StatefulWidget {
  const PostMangerByFollow({super.key});

  @override
  State<PostMangerByFollow> createState() => _PostMangerByFollowState();
}

class _PostMangerByFollowState extends State<PostMangerByFollow>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _PostMangerByFollowT();
  }
}

class _PostMangerByFollowT extends BaseView<PostManagerByFollowController> {
  _PostMangerByFollowT()
      : super(PostManagerByFollowController(), isScreen: false);

  @override
  Widget getMainView(
      BuildContext context, PostManagerByFollowController controller) {
    return StreamBuilder(
        stream: controller.loadStreamFollowPost(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return getSkeletonView(context, controller);
          } else if (snapshot.hasError) {
            return getWarningView('Có lỗi xãy ra => api không chính xác');
          } else {
            if (snapshot.data!.docs.isEmpty) {
              return getEmtpyView();
            }
            return PostManagerList(list: controller.getListPort(snapshot.data));
          }
        });
  }
}
