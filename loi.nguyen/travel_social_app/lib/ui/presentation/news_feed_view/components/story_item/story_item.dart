import 'package:flutter/material.dart';
import 'package:travel_social_app/core/model/user_model.dart';
import 'package:travel_social_app/core/service/singleton.dart';
import 'package:travel_social_app/locator.dart';
import 'package:travel_social_app/ui/resources/color_manager.dart';
import 'package:travel_social_app/ui/resources/styles_manager.dart';

class StoryItem extends StatelessWidget {
  const StoryItem({super.key});

  List<UserModel> get listUser => locator<Singleton>()
      .listUser
      .where((e) => e.img.isNotEmpty)
      .take(5)
      .toList();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
          clipBehavior: Clip.none,
          itemCount: listUser.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => itemCard(listUser[index])),
    );
  }

  Widget itemCard(UserModel userModel) {
    return GestureDetector(
      child: Container(
        width: 120,
        padding: const EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: ColorManager.greyTF),
        child: Column(
          children: [
            Image.network(
              userModel.showImg,
              fit: BoxFit.cover,
              width: 90,
              height: 90,
            ),
            const SizedBox(height: 16),
            Text(
              userModel.showName,
              style: getTitle2Text(color: ColorManager.black),
              maxLines: 1,
            )
          ],
        ),
      ),
    );
  }
}
