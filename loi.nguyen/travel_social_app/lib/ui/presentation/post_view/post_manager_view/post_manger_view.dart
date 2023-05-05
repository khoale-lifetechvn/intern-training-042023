import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_social_app/core/model/base_table.dart';
import 'package:travel_social_app/core/model/user_model.dart';
import 'package:travel_social_app/core/service/api.dart';
import 'package:travel_social_app/core/extension/extension.dart';
import 'package:travel_social_app/core/service/get_navigation.dart';
import 'package:travel_social_app/core/service/singleton.dart';
import 'package:travel_social_app/locator.dart';
import 'package:travel_social_app/ui/base_widget/base_skeleton.dart';
import 'package:travel_social_app/ui/base_widget/lf_appbar.dart';
import 'package:travel_social_app/ui/presentation/post_view/post_manager_view/post_manager_all/post_manager_all.dart';
import 'package:travel_social_app/ui/presentation/post_view/post_manager_view/post_manager_by_follow/post_manger_by_follow.dart';
import 'package:travel_social_app/ui/presentation/post_view/post_manager_view/post_manager_by_user/post_manager_by_user.dart';
import 'package:travel_social_app/ui/resources/routes_manager.dart';
import 'package:travel_social_app/ui/resources/styles_manager.dart';

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
        length: 3,
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
                  icon: Icon(Icons.follow_the_signs_sharp),
                  text: "Following",
                ),
                Tab(
                  icon: Icon(Icons.groups_outlined),
                  text: "All posts",
                ),
              ],
            ),
          ),
          body: const _LoadUser(
            child: TabBarView(
              children: [
                PostMangerByUser(),
                PostMangerByFollow(),
                PostMangerAll(),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              locator<GetNavigation>().to(RouterPath.managerPost);
            },
            child: const Icon(Icons.add),
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

class _LoadUser extends StatelessWidget {
  const _LoadUser({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadListUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const BaseSkeleton(content: 'Loading user...');
          } else if (snapshot.hasError) {
            return const BaseSkeleton(content: 'Error when load user');
          } else {
            QuerySnapshot<Object?>? data = snapshot.data;

            if (data!.docs.isEmpty) {
              return Center(
                child: Text(
                  'No data',
                  style: getTitle1Text(),
                ),
              );
            }
            List<UserModel> listUser =
                snapshot.data.toListMap().map((e) => UserModel(e)).toList();
            locator<Singleton>().listUser = listUser;
            return child;
          }
        });
  }

  Future<QuerySnapshot> loadListUser() {
    Api api = Api(BaseTable.users);
    return api.getDataCollection();
  }
}