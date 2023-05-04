import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:travel_social_app/core/service/singleton.dart';
import 'package:travel_social_app/locator.dart';
import 'package:travel_social_app/ui/base_widget/base_skeleton.dart';
import 'package:travel_social_app/ui/pages/explore.dart';
import 'package:travel_social_app/ui/presentation/news_feed_view/news_feed_view.dart';
import 'package:travel_social_app/ui/pages/trips.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  PageController? _pageController;
  int _page = 0;
  int selectedItem = 0;
  bool isNeedLoading = true;

  Widget pageWidget() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      onPageChanged: onPageChanged,
      children: const [
        NewsFeedView(),
        Explore(),
        Trips(),
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
              InkWell(
                onTap: () {
                  setState(() {
                    navigationTapped(0);
                  });
                  selectItem(0);
                },
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: 0 == selectedItem ? Colors.red : Colors.grey[300],
                  ),
                  child: Center(
                    child: Icon(
                      Iconsax.home,
                      color: 0 == selectedItem ? Colors.white : Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  setState(() {
                    navigationTapped(1);
                  });
                  selectItem(1);
                },
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: 1 == selectedItem ? Colors.red : Colors.grey[300],
                  ),
                  child: Center(
                    child: Icon(
                      Ionicons.compass_outline,
                      color: 1 == selectedItem ? Colors.white : Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  setState(() {
                    navigationTapped(2);
                  });
                  selectItem(2);
                },
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: 2 == selectedItem ? Colors.red : Colors.grey[300],
                  ),
                  child: Center(
                    child: Icon(
                      Iconsax.menu_board,
                      color: 2 == selectedItem ? Colors.white : Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: const Center(
                      child: Icon(
                        Ionicons.add,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController!.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController!.dispose();
  }

  selectItem(page) {
    setState(() {
      selectedItem = page;
    });
  }
}
