import 'package:flutter/material.dart';
import 'package:travel_social_app/core/model/user_model.dart';
import 'package:travel_social_app/core/service/get_navigation.dart';
import 'package:travel_social_app/locator.dart';
import 'package:travel_social_app/ui/base_widget/search_item.dart';
import 'package:travel_social_app/ui/resources/assets_manager.dart';
import 'package:travel_social_app/ui/resources/color_manager.dart';
import 'package:travel_social_app/ui/resources/routes_manager.dart';
import 'package:travel_social_app/ui/resources/styles_manager.dart';
import 'package:travel_social_app/ui/resources/values_manager.dart';

class FindUserList extends StatefulWidget {
  const FindUserList(
      {super.key, required this.list, required this.trailingItem});
  final List<UserModel> list;
  final Widget Function(UserModel) trailingItem;

  @override
  State<FindUserList> createState() => _FindUserListState();
}

class _FindUserListState extends State<FindUserList> {
  late List<UserModel> allUser;
  List<UserModel> currentUsers = [];

  bool isShowList = true;

  void updateState() {
    setState(() {
      isShowList = !isShowList;
    });
  }

  @override
  void initState() {
    allUser = widget.list;
    currentUsers.addAll(widget.list);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FindUserList oldWidget) {
    update();
    super.didUpdateWidget(oldWidget);
  }

  void update() {
    allUser = widget.list;
    List<UserModel> newListUpdate = allUser
        .where((e) => currentUsers.any((eCurrent) => eCurrent.id == e.id))
        .toList();
    currentUsers = newListUpdate;
  }

  void findUsers(String keyword) {
    currentUsers.clear();
    setState(() {
      currentUsers.addAll(allUser);
      if (keyword.isNotEmpty) {
        currentUsers.retainWhere((user) =>
            user.name.toLowerCase().contains(keyword.toLowerCase()) ||
            user.email.toLowerCase().contains(keyword.toLowerCase()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SearchItem(
              hint: 'Search user',
              onChanged: (v) {
                findUsers(v);
              }),
          TextButton(
              onPressed: updateState,
              child: isShowList
                  ? Text(
                      'Show Grid',
                      style: getTitle1Text(color: ColorManager.black),
                    )
                  : Text(
                      'Show Grid',
                      style: getTitle1Text(color: ColorManager.blue),
                    )),
          Expanded(
            child: isShowList
                ? ListView.separated(
                    itemCount: currentUsers.length,
                    separatorBuilder: (_, __) => Divider(
                        height: 16, color: ColorManager.greyBG, thickness: 0.4),
                    itemBuilder: (_, index) => itemUserList(
                      model: currentUsers[index],
                    ),
                  )
                : GridView.builder(
                    itemCount: currentUsers.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16),
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (_, index) => itemUserGrid(
                      model: currentUsers[index],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget itemUserList({required UserModel model}) {
    return ListTile(
      leading: model.img.isEmpty
          ? AspectRatio(aspectRatio: 1, child: Image.asset(ImageAssets.mewo))
          : AspectRatio(aspectRatio: 1, child: Image.network(model.img)),
      title: Text(
        model.showName,
        style: getTitle1Text(),
      ),
      trailing: widget.trailingItem(model),
      subtitle: Text(
        'Email: ${model.email}',
        style: getLabelText(),
      ),
      onTap: () {
        locator<GetNavigation>().to(RouterPath.detailAuthor, arguments: model);
      },
    );
  }

  Widget itemUserGrid({required UserModel model}) {
    return InkWell(
      onTap: () {
        locator<GetNavigation>().to(RouterPath.detailAuthor, arguments: model);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: ColorManager.blue,
                border: Border.all(color: ColorManager.greyForm, width: 0.3)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.showName,
                  style: getTitle1Text(color: ColorManager.white),
                ),
                const SizedBox(height: AppSize.s12),
                Image.network(
                  model.showImg,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          Positioned(top: -10, right: -10, child: widget.trailingItem(model))
        ],
      ),
    );
  }
}
