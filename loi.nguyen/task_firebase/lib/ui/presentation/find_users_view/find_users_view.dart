import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_firebase/core/model/base_table.dart';
import 'package:task_firebase/core/model/user_following_model.dart';
import 'package:task_firebase/core/model/user_model.dart';
import 'package:task_firebase/ui/base/base_controller.dart';
import 'package:task_firebase/core/extension/extension.dart';
import 'package:task_firebase/ui/base_widget/lf_appbar.dart';
import 'package:task_firebase/ui/presentation/find_users_view/components/find_users_list.dart';

class FindUsersView extends StatefulWidget {
  const FindUsersView({super.key});
  @override
  State<FindUsersView> createState() => _FindUsersViewState();
}

class _FindUsersViewState extends State<FindUsersView> {
  late Future<QuerySnapshot<Object?>?> _usersFuture;
  late Stream<QuerySnapshot<Object?>?> _followingStream;

  @override
  void initState() {
    super.initState();
    _usersFuture = FirebaseFirestore.instance.collection(BaseTable.users).get();
    _followingStream = FirebaseFirestore.instance
        .collectionGroup(BaseTable.userFollowing)
        .snapshots();
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
          return StreamBuilder<QuerySnapshot<Object?>?>(
              stream: _followingStream,
              builder: (_, followingSnapshot) {
                List<UserModel> list = mergeListUserFollowing(
                    listUser: listUser.toList(),
                    listUserFollowing: followingSnapshot.data
                        .toListMapCustom()
                        .map((e) => UserFollowingModel(e))
                        .toList());

                if (followingSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: FindUserList(list: list),
                );
              });
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
