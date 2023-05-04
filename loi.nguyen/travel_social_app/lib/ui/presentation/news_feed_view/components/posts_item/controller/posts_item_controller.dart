import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_social_app/core/extension/extension.dart';
import 'package:travel_social_app/core/extension/methods.dart';
import 'package:travel_social_app/core/model/base_table.dart';
import 'package:travel_social_app/core/model/field_name.dart';
import 'package:travel_social_app/core/model/port_user_model.dart';
import 'package:travel_social_app/core/service/api_group.dart';
import 'package:travel_social_app/core/service/api_nosql.dart';
import 'package:travel_social_app/core/service/singleton.dart';
import 'package:travel_social_app/locator.dart';
import 'package:travel_social_app/ui/base/base_controller.dart';

class PostsItemController extends BaseController {
  ApiGroup apiPosts = ApiGroup(BaseTable.userPosts);

  List<Map<String, dynamic>> dataPosts = [];

  List<PostUserModel> get listPostUser {
    List<PostUserModel> temp = [];
    for (var ePost in dataPosts){
      for (var eUser in locator<Singleton>().listUser){
        //  if(Methods.getString(e, FieldName.refID)==)
      }
    }
  }

  @override
  void setData(QuerySnapshot<Object?>? value) {
    dataPosts.clear();
    dataPosts.addAll(value.toListMapCustom());
  }

  @override
  Future<QuerySnapshot<Object?>?>? loadData() {
    return apiPosts.ref.limit(5).get();
  }
}
