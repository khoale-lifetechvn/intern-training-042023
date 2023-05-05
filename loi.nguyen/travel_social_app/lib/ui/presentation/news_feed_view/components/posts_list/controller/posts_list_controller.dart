import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_social_app/core/extension/extension.dart';
import 'package:travel_social_app/core/extension/methods.dart';
import 'package:travel_social_app/core/model/base_table.dart';
import 'package:travel_social_app/core/model/field_name.dart';
import 'package:travel_social_app/core/model/port_user_model.dart';
import 'package:travel_social_app/core/model/user_model.dart';
import 'package:travel_social_app/core/service/api_group.dart';
import 'package:travel_social_app/core/service/singleton.dart';
import 'package:travel_social_app/locator.dart';
import 'package:travel_social_app/ui/base/base_controller.dart';

class PostsListController extends BaseController {
  ApiGroup apiPosts = ApiGroup(BaseTable.userPosts);

  List<Map<String, dynamic>> dataPosts = [];

  List<UserModel> get listUser => locator<Singleton>().listUser;

  List<PostUserModel> get listPostUser {
    List<Map<String, dynamic>> temp = [];

    for (var eUser in listUser) {
      for (var ePost in dataPosts) {
        if (Methods.getString(ePost, FieldName.refID) == eUser.id) {
          temp.add({BaseTable.users: eUser.data, BaseTable.posts: ePost});
          break;
        }
      }
    }
    return temp.map((e) => PostUserModel(e)).take(5).toList();
  }

  @override
  void setData(QuerySnapshot<Object?>? value) {
    dataPosts.clear();
    dataPosts.addAll(value.toListMapCustom());
  }

  @override
  Future<QuerySnapshot<Object?>?>? loadData() {
    return apiPosts.ref.get();
  }
}
