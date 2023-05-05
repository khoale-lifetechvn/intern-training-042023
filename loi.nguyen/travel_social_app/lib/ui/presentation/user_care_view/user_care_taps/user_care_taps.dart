import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_social_app/core/extension/enum.dart';
import 'package:travel_social_app/core/model/port_user_model.dart';
import 'package:travel_social_app/ui/base/base_view.dart';
import 'package:travel_social_app/ui/base_widget/base_skeleton.dart';
import 'package:travel_social_app/ui/presentation/news_feed_view/components/posts_list/component/post_item.dart';
import 'package:travel_social_app/ui/presentation/user_care_view/user_care_taps/controller/user_care_taps_controller.dart';
import 'package:travel_social_app/ui/resources/color_manager.dart';
import 'package:travel_social_app/ui/resources/styles_manager.dart';

class UserCareTabs extends StatefulWidget {
  const UserCareTabs({super.key, required this.typeBlogs});

  final TypeBlogs typeBlogs;

  @override
  State<UserCareTabs> createState() => _UserCareTabsState();
}

class _UserCareTabsState extends State<UserCareTabs>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _UserCareTabsData(typeBlogs: widget.typeBlogs);
  }

  @override
  bool get wantKeepAlive => true;
}

class _UserCareTabsData extends BaseView<UserCareTapsController> {
  _UserCareTabsData({required TypeBlogs typeBlogs})
      : super(UserCareTapsController(typeBlogs: typeBlogs), isScreen: false);

  @override
  Widget getMainView(BuildContext context, UserCareTapsController controller) {
    return StreamBuilder(
        stream: controller.loadDataStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const BaseSkeleton(content: 'Loading post....');
          } else if (snapshot.hasError) {
            return getWarningView('Có lỗi xãy ra => api không chính xác');
          } else {
            QuerySnapshot<Object?>? data = snapshot.data;
            controller.setDataPostUser(data);
            if (data!.docs.isEmpty) {
              return getEmtpyView();
            }

            return listPost();
          }
        });
  }

  Widget listPost() {
    List<PostUserModel> listPost = controller.listPostUser;

    ///Loadlist here
    return listPost.isEmpty
        ? Center(
            child: Text(
              'There are currently no posts',
              style: getTitle2Text(),
            ),
          )
        : ListView.separated(
            itemCount: listPost.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            separatorBuilder: (_, __) => Divider(
              height: 16,
              thickness: 0.3,
              color: ColorManager.greyForm,
            ),
            itemBuilder: (_, index) =>
                PostItem(postUser: listPost[index], isFollow: false),
          );
  }
}
