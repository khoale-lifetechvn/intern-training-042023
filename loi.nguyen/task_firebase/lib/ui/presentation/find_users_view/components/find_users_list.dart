import 'package:flutter/material.dart';
import 'package:task_firebase/core/extension/enum.dart';
import 'package:task_firebase/core/model/base_table.dart';
import 'package:task_firebase/core/model/user_model.dart';
import 'package:task_firebase/core/service/api_nosql.dart';
import 'package:task_firebase/core/service/get_navigation.dart';
import 'package:task_firebase/core/service/singleton.dart';
import 'package:task_firebase/locator.dart';
import 'package:task_firebase/ui/base_widget/lf_dialog.dart';
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
  late List<UserModel> allUser;
  List<UserModel> currentUsers = [];

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

  void updateFollow(String userID) {
    final ApiNosql apiNosql = ApiNosql(
        parentTable: BaseTable.following,
        parentID: userID,
        childTable: BaseTable.userFollowing);
    apiNosql.addDocumentNN(id: locator<Singleton>().userModel.id).then((value) {
      if (value == Status.add.name) {
        locator<GetNavigation>().openDialog(
            content: 'Follow Successfully', typeDialog: TypeDialog.sucesss);
      } else if (value == Status.remove.name) {
        locator<GetNavigation>().openDialog(
            content: 'Unfollow Successfully', typeDialog: TypeDialog.sucesss);
      } else {
        locator<GetNavigation>().openDialog(content: value);
      }
    });
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
              separatorBuilder: (_, __) => Divider(
                  height: 16, color: ColorManager.greyBG, thickness: 0.4),
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
      title: Text(
        model.showName,
        style: getTitleText(),
      ),
      trailing: IconButton(
        onPressed: () {
          updateFollow(model.id);
        },
        icon: model.isFollow
            ? Icon(
                Icons.favorite,
                color: ColorManager.red,
              )
            : const Icon(Icons.favorite_border),
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
