import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:travel_social_app/core/service/get_navigation.dart';
import 'package:travel_social_app/core/service/singleton.dart';
import 'package:travel_social_app/locator.dart';
import 'package:travel_social_app/ui/base_widget/base_skeleton.dart';
import 'package:travel_social_app/ui/presentation/explore_view/explore_view.dart';
import 'package:travel_social_app/ui/presentation/news_feed_view/news_feed_view.dart';
import 'package:travel_social_app/ui/presentation/user_care_view/user_care_view.dart';
import 'package:travel_social_app/ui/resources/routes_manager.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _pageIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  bool isNeedLoading = true;

  Widget pageWidget() {
    return PageView(
      controller: _pageController,
      onPageChanged: onPageChanged,
      children: [
        const NewsFeedView(),
        ExploreView(),
        const UserCareView(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isNeedLoading
          ? FutureBuilder(
              future: locator<Singleton>().loadDefaultData(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const BaseSkeleton(
                    content: 'Loading...',
                  );
                } else if (snapshot.hasError) {
                  return BaseSkeleton(
                    content: 'Error...${snapshot.error}',
                  );
                } else {
                  isNeedLoading = false;
                  return pageWidget();
                }
              },
            )
          : pageWidget(),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0, left: 15),
          child: Row(
            children: [
              iconButton(index: 0, icon: Iconsax.home),
              const SizedBox(width: 10),
              iconButton(index: 1, icon: Ionicons.compass_outline),
              const SizedBox(width: 10),
              iconButton(index: 2, icon: Iconsax.menu_board),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    locator<GetNavigation>().to(RouterPath.managerPost);
                  },
                  icon: const Icon(Icons.add)),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconButton({required int index, required IconData icon}) {
    return InkWell(
      onTap: () {
        onPageChanged(index);
        _pageController.animateToPage(index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      },
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _pageIndex == index ? Colors.red : Colors.grey[300],
        ),
        child: Center(
          child: Icon(
            icon,
            color: _pageIndex == index ? Colors.white : Colors.black,
            size: 20,
          ),
        ),
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      _pageIndex = page;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
