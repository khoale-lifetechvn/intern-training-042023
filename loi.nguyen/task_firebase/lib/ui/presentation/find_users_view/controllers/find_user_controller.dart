import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_firebase/core/extension/methods.dart';
import 'package:task_firebase/core/model/base_table.dart';
import 'package:task_firebase/core/model/field_name.dart';
import 'package:task_firebase/core/model/user_model.dart';
import 'package:task_firebase/core/service/api.dart';
import 'package:task_firebase/core/service/singleton.dart';
import 'package:task_firebase/locator.dart';
import 'package:task_firebase/ui/base/base_controller.dart';

class FindUserViewController extends BaseController {
  final Api _apiUser = Api(BaseTable.users);

  List<UserModel> get listUser {
    //Remove myUser
    data.removeWhere((e) =>
        Methods.getString(e, FieldName.id) ==
        locator<Singleton>().userModel.id);
    return data.map((e) => UserModel(e)).toList();
  }

  @override
  Future<QuerySnapshot<Object?>?>? loadData() {
    return _apiUser.getDataCollection();
  }
}
