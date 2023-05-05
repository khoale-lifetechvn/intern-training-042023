import 'package:travel_social_app/core/extension/methods.dart';
import 'package:travel_social_app/core/model/base_model.dart';
import 'package:travel_social_app/core/model/base_table.dart';
import 'package:travel_social_app/core/model/field_name.dart';
import 'package:travel_social_app/core/model/user_model.dart';

class PostCommentModel extends BaseModel {
  PostCommentModel(super.data);

  ///UserID
  String get userRef => Methods.getString(data, FieldName.userRef);

  String get content => Methods.getString(data, FieldName.content);

  ///info user
  UserModel get user => UserModel(Methods.getMap(data, BaseTable.users));

  DateTime get createdAtDate => Methods.getDateTime(data, FieldName.createdAt);
}
