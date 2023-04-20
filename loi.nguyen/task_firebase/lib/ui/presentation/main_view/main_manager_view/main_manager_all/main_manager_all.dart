import 'package:flutter/material.dart';
import 'package:task_firebase/core/model/post_model.dart';
import 'package:task_firebase/ui/presentation/main_view/main_manager_view/components/main_manager_list.dart';
import 'package:task_firebase/ui/base/base_view.dart';
import 'package:task_firebase/ui/presentation/main_view/main_manager_view/main_manager_all/controller/main_manager_all_controller.dart';

class MainMangerAll extends StatefulWidget {
  const MainMangerAll({super.key});

  @override
  State<MainMangerAll> createState() => _MainMangerAllState();
}

class _MainMangerAllState extends State<MainMangerAll>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _MainMangerAllT();
  }

  @override
  bool get wantKeepAlive => true;
}

class _MainMangerAllT extends BaseView<MainManagerAllController> {
  _MainMangerAllT() : super(MainManagerAllController(), isScreen: false);

  @override
  Widget getMainView(
      BuildContext context, MainManagerAllController controller) {
    List<PostModel> list = controller.list;
    return RefreshIndicator(
        onRefresh: () async {
          controller.reload();
        },
        child: MainManagerList(list: list));
  }
}
