import 'package:flutter/material.dart';
import 'package:task_firebase/core/model/user_model.dart';
import 'package:task_firebase/ui/base_widget/search_item.dart';
import 'package:task_firebase/ui/presentation/find_users_view/components/controller/find_user_list_controller.dart';
import 'package:task_firebase/ui/resources/assets_manager.dart';
import 'package:task_firebase/ui/resources/color_manager.dart';
import 'package:task_firebase/ui/resources/styles_manager.dart';

class FindUserList extends StatefulWidget {
  const FindUserList({super.key, required this.list});
  final List<UserModel> list;

  @override
  State<FindUserList> createState() => _FindUserListState();
}

class _FindUserListState extends State<FindUserList> {
  late List<UserModel> allUser;
  List<UserModel> currentUsers = [];

  FindUserListController controller = FindUserListController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() {
    currentUsers.clear();
    allUser = widget.list;
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
    return Column(
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
    );
  }

  Widget itemUser({required UserModel model}) {
    return ListTile(
      leading: model.img.isEmpty
          ? Image.asset(ImageAssets.mewo)
          : Image.network(model.img),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: ColorManager.black, width: 0.4)),
      trailing: model.userFollowing.isFollow
          ? Icon(
              Icons.favorite,
              color: ColorManager.red,
            )
          : const Icon(Icons.favorite_border),
      title: Text(
        model.name.isEmpty ? 'NoName' : model.name,
        style: getTitleText(),
      ),
      subtitle: Text(
        'Email: ${model.email}',
        style: getLabelText(),
      ),
      onTap: () {
        controller.updateFollow(model.id);
      },
    );
  }
}
