import 'package:task_firebase/core/extension/methods.dart';
import 'package:task_firebase/core/model/base_model.dart';
import 'package:task_firebase/core/model/base_table.dart';
import 'package:task_firebase/core/model/field_name.dart';
import 'package:task_firebase/core/model/user_model.dart';

class PostCommentModel extends BaseModel {
  PostCommentModel(super.data);

  ///UserID
  String get userRef => Methods.getString(data, FieldName.userRef);

  String get content => Methods.getString(data, FieldName.content);

  ///info user
  UserModel get user => Methods.getMap(data, BaseTable.users);

  DateTime get createdAtDate => Methods.getDateTime(data, FieldName.createdAt);
}
