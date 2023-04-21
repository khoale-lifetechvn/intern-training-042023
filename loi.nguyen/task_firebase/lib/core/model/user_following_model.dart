import 'package:task_firebase/core/extension/methods.dart';
import 'package:task_firebase/core/model/base_model.dart';
import 'package:task_firebase/core/model/field_name.dart';
import 'package:task_firebase/core/service/singleton.dart';
import 'package:task_firebase/locator.dart';

class UserFollowingModel extends BaseModel {
  UserFollowingModel(super.data);

  ///ParenID or Id of following
  String get refID => Methods.getString(data, FieldName.refID);

  ///
  bool get isFollow => id == locator<Singleton>().userModel.id;
}
