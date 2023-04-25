import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_firebase/core/model/base_table.dart';
import 'package:task_firebase/core/model/user_following_model.dart';
import 'package:task_firebase/core/model/user_model.dart';
import 'package:task_firebase/core/extension/extension.dart';
import 'package:task_firebase/core/service/singleton.dart';
import 'package:task_firebase/locator.dart';
import 'package:task_firebase/ui/base_widget/lf_appbar.dart';
import 'package:task_firebase/ui/presentation/find_users_view/components/find_users_list.dart';

class FindUsersView extends StatefulWidget {
  const FindUsersView({super.key});
  @override
  State<FindUsersView> createState() => _FindUsersViewState();
}

class _FindUsersViewState extends State<FindUsersView> {
  late Future<QuerySnapshot<Object?>?> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = FirebaseFirestore.instance.collection(BaseTable.users).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LFAppBar(title: 'Find Users'),
      body: FutureBuilder(
        future: _usersFuture,
        builder: (_, usersSnapshot) {
          if (!usersSnapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<UserModel> listUser =
              usersSnapshot.data!.toListMap().map((e) => UserModel(e)).toList();
          locator<Singleton>().listUser = listUser;
          return FindUserList(list: listUser);
        },
      ),
    );
  }

  List<UserModel> mergeListUserFollowing({
    required List<UserModel> listUser,
    required List<UserFollowingModel> listUserFollowing,
  }) {
    List<Map<String, dynamic>> temp = [];

    for (int i = 0; i < listUser.length; i++) {
      Map<String, dynamic> userData = Map.from(listUser[i].data);
      for (var eUserFollowing in listUserFollowing) {
        if (listUser[i].id == eUserFollowing.refID) {
          userData.addAll({
            BaseTable.userFollowing: eUserFollowing.data,
          });
        }
      }
      temp.add(userData);
    }
    return temp.map((e) => UserModel(e)).toList();
  }
}
