import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:travel_social_app/core/model/user_model.dart';
import 'package:travel_social_app/ui/presentation/explore_view/controller/explore_controller.dart';
import 'package:travel_social_app/ui/presentation/home_view/base_home_view.dart';
import 'package:travel_social_app/ui/presentation/news_feed_view/components/posts_list/component/post_follow_item.dart';
import 'package:travel_social_app/ui/resources/color_manager.dart';
import 'package:travel_social_app/ui/resources/styles_manager.dart';
import 'package:travel_social_app/ui/utils/data.dart';

class ExploreView extends BaseHomeView {
  ExploreView({super.key});

  final ExploreController controller = ExploreController();

  @override
  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.custom(
        gridDelegate: SliverWovenGridDelegate.count(
          pattern: const [
            WovenGridTile(1),
          ],
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
        ),
        childrenDelegate: SliverChildBuilderDelegate(
          (_, int index) {
            List<UserModel> list = controller.listUser;
            return Container(
              decoration: BoxDecoration(
                color: ColorManager.greyTF,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(list[index].showImg),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        list[index].showName,
                        style: getTitle3Text(color: ColorManager.black),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: PostFollowItem(
                        uid: list[index].id, isIconFavorite: true),
                  )
                ],
              ),
            );
          },
          childCount: data.length,
        ),
      ),
    );
  }
}
