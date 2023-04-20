import 'package:flutter/material.dart';
import 'package:task_firebase/core/model/post_model.dart';
import 'package:task_firebase/ui/presentation/post_view/post_manager_view/components/post_manager_list.dart';
import 'package:task_firebase/ui/base/base_view.dart';
import 'package:task_firebase/ui/presentation/post_view/post_manager_view/post_manager_all/controller/post_manager_all_controller.dart';

class PostMangerAll extends StatefulWidget {
  const PostMangerAll({super.key});

  @override
  State<PostMangerAll> createState() => _PostMangerAllState();
}

class _PostMangerAllState extends State<PostMangerAll>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _PostMangerAllT();
  }

  @override
  bool get wantKeepAlive => true;
}

class _PostMangerAllT extends BaseView<PostManagerAllController> {
  _PostMangerAllT() : super(PostManagerAllController(), isScreen: false);

  @override
  Widget getMainView(
      BuildContext context, PostManagerAllController controller) {
    List<PostModel> list = controller.list;
    return RefreshIndicator(
        onRefresh: () async {
          controller.reload();
        },
        child: PostManagerList(list: list));
  }
}
