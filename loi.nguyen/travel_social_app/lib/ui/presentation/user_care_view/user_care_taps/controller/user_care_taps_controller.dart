import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_social_app/core/extension/enum.dart';
import 'package:travel_social_app/core/extension/extension.dart';
import 'package:travel_social_app/core/extension/methods.dart';
import 'package:travel_social_app/core/model/base_table.dart';
import 'package:travel_social_app/core/model/field_name.dart';
import 'package:travel_social_app/core/model/port_user_model.dart';
import 'package:travel_social_app/core/model/post_model.dart';
import 'package:travel_social_app/core/model/user_model.dart';
import 'package:travel_social_app/core/service/api_group.dart';
import 'package:travel_social_app/core/service/singleton.dart';
import 'package:travel_social_app/locator.dart';
import 'package:travel_social_app/ui/base/base_controller.dart';

class UserCareTapsController extends BaseController {
  UserCareTapsController({required this.typeBlogs});
  final TypeBlogs typeBlogs;

  final ApiGroup _apiAllPost = ApiGroup(BaseTable.userPosts);

  List<UserModel> listUserFollow = [];

  List<PostUserModel> listPostUser = [];

  //Get follow by user
  @override
  void setData(QuerySnapshot<Object?>? value) {
    listUserFollow.clear();
    listUserFollow
        .addAll(value.toListMapCustom().map((e) => UserModel(e)).toList());
  }

  void setDataPostUser(QuerySnapshot<Object?>? value) {
    List<PostModel> listPost =
        value.toListMapCustom().map((e) => PostModel(e)).toList();

    listPostUser.clear();

    switch (typeBlogs) {
      case TypeBlogs.all:
        _handleAll(listPost);
        break;
      case TypeBlogs.follow:
        _handleFollowing(listPost);
        break;
      case TypeBlogs.thisAccount:
        _handleThisAccount(listPost);
        break;
    }
  }

  void _handleAll(List<PostModel> listPost) {
    List<Map<String, dynamic>> temp = [];

    for (var ePost in listPost) {
      for (var eUser in locator<Singleton>().listUser) {
        if (Methods.getString(ePost.data, FieldName.refID) == eUser.id) {
          temp.add({BaseTable.users: eUser.data, BaseTable.posts: ePost.data});

          break;
        }
      }
    }
    listPostUser = temp.map((e) => PostUserModel(e)).toList();
  }

  void _handleFollowing(List<PostModel> listPost) {
    List<Map<String, dynamic>> temp = [];

    for (var ePost in listPost) {
      for (var eUser in listUserFollow) {
        if (Methods.getString(ePost.data, FieldName.refID) == eUser.id) {
          temp.add({BaseTable.users: eUser.data, BaseTable.posts: ePost.data});
          break;
        }
      }
    }

    listPostUser.addAll(temp.map((e) => PostUserModel(e)).toList());
  }

  void _handleThisAccount(List<PostModel> listPost) {
    List<Map<String, dynamic>> temp = [];
    for (var ePost in listPost) {
      if (Methods.getString(ePost.data, FieldName.refID) == userID) {
        temp.add({
          BaseTable.users: locator<Singleton>().userModel.data,
          BaseTable.posts: ePost.data
        });
        break;
      }
    }
    listPostUser.addAll(temp.map((e) => PostUserModel(e)).toList());
  }

  @override
  Stream<QuerySnapshot<Object?>?>? loadDataStream() {
    return _apiAllPost.streamData();
  }

  @override
  Future<QuerySnapshot<Object?>?>? loadData() {
    ApiGroup userFollowing = ApiGroup(BaseTable.userFollowing);
    return userFollowing.ref.where(FieldName.selfId, isEqualTo: userID).get();
  }
}
