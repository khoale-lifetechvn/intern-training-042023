import 'package:flutter/material.dart';
import 'package:task_firebase/core/model/user_model.dart';
import 'package:task_firebase/core/service/get_navigation.dart';
import 'package:task_firebase/locator.dart';
import 'package:task_firebase/ui/base_widget/search_item.dart';
import 'package:task_firebase/ui/resources/assets_manager.dart';
import 'package:task_firebase/ui/resources/color_manager.dart';
import 'package:task_firebase/ui/resources/routes_manager.dart';
import 'package:task_firebase/ui/resources/styles_manager.dart';

class FindUserList extends StatefulWidget {
  const FindUserList({super.key, required this.list});
  final List<UserModel> list;

  @override
  State<FindUserList> createState() => _FindUserListState();
}

class _FindUserListState extends State<FindUserList> {
  List<UserModel> allUser = [];
  List<UserModel> currentUsers = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() {
    currentUsers.clear();
    allUser.addAll(widget.list);
    currentUsers.addAll(widget.list);
  }

  @override
  void didUpdateWidget(covariant FindUserList oldWidget) {
    getData();
    super.didUpdateWidget(oldWidget);
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SearchItem(
              hint: 'Search user',
              onChanged: (v) {
                findUsers(v);
              }),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.separated(
              itemCount: currentUsers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (_, index) => itemUser(
                model: currentUsers[index],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemUser({required UserModel model}) {
    return ListTile(
      leading: model.img.isEmpty
          ? AspectRatio(aspectRatio: 1, child: Image.asset(ImageAssets.mewo))
          : AspectRatio(aspectRatio: 1, child: Image.network(model.img)),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: ColorManager.black, width: 0.4)),
      title: Text(
        model.showName,
        style: getTitleText(),
      ),
      subtitle: Text(
        'Email: ${model.email}',
        style: getLabelText(),
      ),
      onTap: () {
        locator<GetNavigation>()
            .to(RouterPath.detailFollowUserView, arguments: model);
      },
    );
  }
}
