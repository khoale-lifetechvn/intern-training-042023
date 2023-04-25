import 'package:task_firebase/core/extension/methods.dart';
import 'package:task_firebase/core/model/base_model.dart';
import 'package:task_firebase/core/model/base_table.dart';
import 'package:task_firebase/core/model/field_name.dart';
import 'package:task_firebase/core/model/user_following_model.dart';
import 'package:task_firebase/core/service/singleton.dart';
import 'package:task_firebase/locator.dart';

class UserModel extends BaseModel {
  UserModel(super.data);

  String get name => Methods.getString(data, FieldName.name);

  String get showName => name.isEmpty ? 'No Name' : name;

  String get email => Methods.getString(data, FieldName.email);

  String get dbo => Methods.getString(data, FieldName.dbo);

  List<UserFollowingModel> get listUserFollow =>
      Methods.getList(data, BaseTable.userFollowing)
          .map((e) => UserFollowingModel(e))
          .toList();

  @override
  String get img => super.img.isEmpty
      ? 'https://upload.wikimedia.org/wikipedia/commons/5/54/Deus_reading.png'
      : super.img;

  bool get isFollow {
    for (var e in listUserFollow) {
      if (e.id == locator<Singleton>().userModel.id) {
        return true;
      }
    }
    return false;
  }
}
