import 'package:travel_social_app/core/extension/methods.dart';
import 'package:travel_social_app/core/model/base_model.dart';
import 'package:travel_social_app/core/model/base_table.dart';
import 'package:travel_social_app/core/model/post_model.dart';
import 'package:travel_social_app/core/model/user_model.dart';

//1 post by 1 user
class PostUserModel extends BaseModel {
  PostUserModel(Map<String, dynamic> data) : super(data);

  PostModel get post => PostModel(Methods.getMap(data, BaseTable.posts));
  UserModel get user => UserModel(Methods.getMap(data, BaseTable.users));
}
