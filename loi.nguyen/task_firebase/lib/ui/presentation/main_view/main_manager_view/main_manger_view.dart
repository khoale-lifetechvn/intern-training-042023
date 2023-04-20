import 'package:flutter/material.dart';
import 'package:task_firebase/core/service/get_navigation.dart';
import 'package:task_firebase/locator.dart';
import 'package:task_firebase/ui/base_widget/lf_appbar.dart';
import 'package:task_firebase/ui/presentation/main_view/main_manager_view/main_manager_all/main_manager_all.dart';
import 'package:task_firebase/ui/presentation/main_view/main_manager_view/main_manager_by_user/main_manager_by_user.dart';
import 'package:task_firebase/ui/resources/routes_manager.dart';

class MainManagerView extends StatefulWidget {
  const MainManagerView({Key? key}) : super(key: key);

  @override
  State<MainManagerView> createState() => _MainManagerViewState();
}

class _MainManagerViewState extends State<MainManagerView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: LFAppBar(
            title: 'Manager Posts',
            suffix: IconButton(
                onPressed: () {
                  locator<GetNavigation>().to(RouterPath.user);
                },
                icon: const Icon(Icons.accessibility_rounded)),
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
            children: [
              MainMangerByUser(),
              MainMangerAll(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              locator<GetNavigation>().to(RouterPath.mainAdd);
            },
            child: const Icon(Icons.add),
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
