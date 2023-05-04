import 'package:flutter/material.dart';
import 'package:travel_social_app/core/model/emoji_model.dart';
import 'package:travel_social_app/core/service/get_navigation.dart';
import 'package:travel_social_app/locator.dart';
import 'package:travel_social_app/ui/base/base_view.dart';
import 'package:travel_social_app/ui/base_widget/lf_appbar.dart';
import 'package:travel_social_app/ui/presentation/emoji_view/controller/emoji_cotroller.dart';
import 'package:travel_social_app/ui/resources/color_manager.dart';
import 'package:travel_social_app/ui/resources/routes_manager.dart';
import 'package:travel_social_app/ui/resources/styles_manager.dart';

class EmojiView extends BaseView<EmojiController> {
  EmojiView({super.key}) : super(EmojiController());

  @override
  Widget getMainView(BuildContext context, EmojiController controller) {
    List<EmojiModel> list = controller.listEmoji;
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: controller.listEmoji.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (_, index) => cardEmoji(list[index]),
    );
  }

  Widget cardEmoji(EmojiModel emojiModel) {
    return ListTile(
      onTap: () {
        locator<GetNavigation>()
            .to(RouterPath.detailEmoji, arguments: emojiModel);
      },
      leading: AspectRatio(
        aspectRatio: 1,
        child: Image.network(
          emojiModel.img,
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: ColorManager.greyBG)),
      title: Text(
        emojiModel.title,
        style: getTitle1Text(),
      ),
      subtitle: Text(
        'Index: ${emojiModel.index}',
        style: getLabelText(color: ColorManager.greyBG),
      ),
    );
  }

  @override
  Widget? floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        locator<GetNavigation>().to(RouterPath.detailEmoji);
      },
      child: const Icon(Icons.add),
    );
  }

  @override
  AppBar? appBar(BuildContext context) {
    return LFAppBar(title: 'Manager Emoji');
  }
}
