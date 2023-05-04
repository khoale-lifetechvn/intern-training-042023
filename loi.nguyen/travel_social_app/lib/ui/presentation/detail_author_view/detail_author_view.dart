import 'package:flutter/material.dart';
import 'package:travel_social_app/core/model/user_model.dart';
import 'package:travel_social_app/ui/base/base_view.dart';
import 'package:travel_social_app/ui/base_widget/lf_appbar.dart';
import 'package:travel_social_app/ui/presentation/block_user_view/default_block_view.dart';
import 'package:travel_social_app/ui/presentation/detail_author_view/controller/detail_author_controller.dart';

import 'package:travel_social_app/ui/presentation/detail_author_view/list_posts_user/list_posts_user.dart';
import 'package:travel_social_app/ui/resources/color_manager.dart';
import 'package:travel_social_app/ui/resources/styles_manager.dart';

class DetailAuthorView extends BaseView<DetailAuthorController> {
  DetailAuthorView({super.key, required this.user})
      : super(DetailAuthorController(user.id), isScreen: false);
  final UserModel user;

  @override
  Widget getEmtpyView() {
    controller.clearData();
    return view();
  }

  @override
  Widget getMainView(BuildContext context, DetailAuthorController controller) {
    return view();
  }

  Widget view() {
    return user.isBlockThisAccount ? const DefaultBlockView() : infoAuthor();
  }

  Widget infoAuthor() {
    return Scaffold(
      appBar: LFAppBar(title: 'Detail Author'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.network(
                user.showImg,
                height: 250,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    user.showName,
                    style: getTitle1Text(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                IconButton(
                  onPressed: () {
                    controller.updateFollow();
                  },
                  icon: controller.isFollow
                      ? Icon(
                          Icons.favorite,
                          color: ColorManager.red,
                        )
                      : const Icon(Icons.favorite_border),
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(
              user.email,
              style: getLabelText(color: ColorManager.greyBG),
            ),
            Divider(
              color: ColorManager.greyTF,
              height: 16,
            ),
            infoFollow(),
            Divider(
              color: ColorManager.greyTF,
              height: 16,
            ),
            Expanded(
              child: ListPostsUser(
                userID: user.id,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget infoFollow() {
    return Column(
      children: [
        Text('Number follow: ${controller.listIdUserFollow.length}'),
        const SizedBox(height: 16),
      ],
    );
  }
}
