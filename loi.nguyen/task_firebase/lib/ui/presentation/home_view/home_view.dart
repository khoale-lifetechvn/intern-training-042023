import 'package:flutter/material.dart';
import 'package:task_firebase/core/service/get_navigation.dart';
import 'package:task_firebase/core/service/singleton.dart';
import 'package:task_firebase/locator.dart';
import 'package:task_firebase/ui/base_widget/base_skeleton.dart';

import 'package:task_firebase/ui/base_widget/lf_appbar.dart';
import 'package:task_firebase/ui/resources/color_manager.dart';
import 'package:task_firebase/ui/resources/routes_manager.dart';
import 'package:task_firebase/ui/resources/styles_manager.dart';
import 'package:task_firebase/ui/resources/values_manager.dart';

class _ItemCard {
  final String title;
  final IconData icon;
  final Function() onPressed;
  _ItemCard({
    required this.title,
    required this.icon,
    required this.onPressed,
  });
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  List<_ItemCard> get _list => [
        _ItemCard(
            title: 'Following',
            icon: Icons.search,
            onPressed: () {
              locator<GetNavigation>().to(RouterPath.followUsers);
            }),
        _ItemCard(
            title: 'View posts',
            icon: Icons.add_reaction_rounded,
            onPressed: () {
              locator<GetNavigation>().to(RouterPath.postManager);
            }),
        _ItemCard(
            title: 'User',
            icon: Icons.medical_information_rounded,
            onPressed: () {
              locator<GetNavigation>().to(RouterPath.user);
            }),
        _ItemCard(
            title: 'Block users',
            icon: Icons.block,
            onPressed: () {
              locator<GetNavigation>().to(RouterPath.blockUsers);
            }),
        _ItemCard(
            title: 'Emoji',
            icon: Icons.emoji_emotions,
            onPressed: () {
              locator<GetNavigation>().to(RouterPath.emoji);
            })
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LFAppBar(title: 'Home'),
      body: afterBuilding(
          child: GridView.builder(
        itemCount: _list.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16),
        padding: const EdgeInsets.all(16),
        itemBuilder: (_, index) => _item(
          item: _list[index],
        ),
      )),
    );
  }

  Widget afterBuilding({required Widget child}) {
    return FutureBuilder(
      future: locator<Singleton>().loadDefaultData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const BaseSkeleton(content: 'Đang tải dữ liệu....');
        } else if (snapshot.hasError) {
          return const BaseSkeleton(content: 'Có lỗi xãy ra');
        }
        return child;
      },
    );
  }

  Widget _item({required _ItemCard item}) {
    return InkWell(
      onTap: item.onPressed,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: ColorManager.greyBG,
            border: Border.all(color: ColorManager.greyForm, width: 0.3)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              color: ColorManager.white,
              size: 40,
            ),
            const SizedBox(height: AppSize.s28),
            Text(
              item.title,
              style: getTitleText(color: ColorManager.white),
            ),
          ],
        ),
      ),
    );
  }
}
