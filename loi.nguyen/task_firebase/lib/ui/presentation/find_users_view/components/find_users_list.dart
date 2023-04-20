import 'package:flutter/material.dart';
import 'package:task_firebase/core/model/user_model.dart';
import 'package:task_firebase/ui/base_widget/search_item.dart';
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

  @override
  void initState() {
    allUser = widget.list;
    currentUsers.addAll(widget.list);
    super.initState();
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

  bool isFollow = false;

  Widget itemUser({required UserModel model}) {
    return ListTile(
      leading: Image.asset(ImageAssets.mewo),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      trailing: isFollow
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
      onTap: () {},
    );
  }
}
