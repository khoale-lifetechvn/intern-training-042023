import 'package:flutter/material.dart';
import 'package:travel_social_app/core/extension/enum.dart';
import 'package:travel_social_app/ui/presentation/home_view/base_home_view.dart';
import 'package:travel_social_app/ui/presentation/user_care_view/user_care_taps/user_care_taps.dart';
import 'package:travel_social_app/ui/resources/styles_manager.dart';
import 'package:flutter_point_tab_bar/pointTabBar.dart';

class UserCareView extends StatefulWidget {
  const UserCareView({super.key});

  @override
  State<UserCareView> createState() => _UserCareViewState();
}

class _UserCareViewState extends State<UserCareView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return _MyTrip(_tabController);
  }
}

class _MyTrip extends BaseHomeView {
  const _MyTrip(this.tabController);
  final TabController tabController;
  @override
  Widget buildBody(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Flexible(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: TabBar(
                    controller: tabController,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 25),
                    indicatorColor: const Color(0xfff3f4f9),
                    indicator: const PointTabIndicator(
                      position: PointTabIndicatorPosition.bottom,
                      insets: EdgeInsets.only(bottom: 3),
                      color: Colors.red,
                    ),
                    indicatorWeight: 1.0,
                    isScrollable: true,
                    unselectedLabelColor: Colors.grey,
                    tabs: <Widget>[
                      Tab(
                        child: Text(
                          'All blogs',
                          style: getSmallText(),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Blogs following',
                          style: getSmallText(),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'My Blogs',
                          style: getSmallText(),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: const <Widget>[
                      UserCareTabs(typeBlogs: TypeBlogs.all),
                      UserCareTabs(typeBlogs: TypeBlogs.follow),
                      UserCareTabs(typeBlogs: TypeBlogs.thisAccount),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Trips',
                style: getTitle2Text(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
