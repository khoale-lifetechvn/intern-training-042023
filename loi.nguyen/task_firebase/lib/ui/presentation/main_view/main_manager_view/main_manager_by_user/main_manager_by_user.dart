import 'package:flutter/material.dart';
import 'package:task_firebase/core/model/post_model.dart';
import 'package:task_firebase/ui/presentation/main_view/main_manager_view/components/main_manager_list.dart';
import 'package:task_firebase/ui/presentation/main_view/main_manager_view/main_manager_by_user/controller/main_manager_by_user_controller.dart';
import 'package:task_firebase/ui/base/base_view.dart';

class MainMangerByUser extends StatefulWidget {
  const MainMangerByUser({super.key});

  @override
  State<MainMangerByUser> createState() => _MainMangerByUserState();
}

class _MainMangerByUserState extends State<MainMangerByUser>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _MainMangerByUserT();
  }
}

class _MainMangerByUserT extends BaseView<MainManagerByUserController> {
  _MainMangerByUserT() : super(MainManagerByUserController(), isScreen: false);

  @override
  Widget getMainView(
      BuildContext context, MainManagerByUserController controller) {
    List<PostModel> list = controller.list;
    return MainManagerList(list: list);
  }
}
