import 'package:flutter/material.dart';
import 'package:task_firebase/core/service/get_navigation.dart';
import 'package:task_firebase/locator.dart';
import 'package:task_firebase/ui/base_widget/lf_appbar.dart';
import 'package:task_firebase/ui/presentation/post_view/post_manager_view/post_manager_all/post_manager_all.dart';
import 'package:task_firebase/ui/presentation/post_view/post_manager_view/post_manager_by_user/post_manager_by_user.dart';
import 'package:task_firebase/ui/resources/routes_manager.dart';

class PostManagerView extends StatefulWidget {
  const PostManagerView({Key? key}) : super(key: key);

  @override
  State<PostManagerView> createState() => _PostManagerViewState();
}

class _PostManagerViewState extends State<PostManagerView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: LFAppBar(
            title: 'Manager Posts',
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.medical_information_outlined),
                  text: "My posts",
                ),
                Tab(
                  icon: Icon(Icons.groups_outlined),
                  text: "All posts",
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [PostMangerByUser(), PostMangerAll()],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              locator<GetNavigation>().to(RouterPath.postAdd);
            },
            child: const Icon(Icons.add),
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
