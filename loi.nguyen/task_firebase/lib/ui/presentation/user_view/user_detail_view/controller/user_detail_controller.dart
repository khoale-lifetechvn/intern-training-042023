import 'package:task_firebase/core/model/base_table.dart';
import 'package:task_firebase/core/model/field_name.dart';
import 'package:task_firebase/core/model/user_model.dart';
import 'package:task_firebase/core/service/api.dart';
import 'package:task_firebase/core/service/get_navigation.dart';
import 'package:task_firebase/core/service/singleton.dart';
import 'package:task_firebase/locator.dart';

class UserDetailController {
  final Api _api = Api(BaseTable.users);

  String? _name;
  String? _dbo;

  UserModel get user => locator<Singleton>().userModel;

  set name(String? value) {
    _name = value;
  }

  set dbo(String? value) {
    _dbo = value;
  }

  void updateUser() async {
    await _api.updateDocument({FieldName.name: _name, FieldName.dbo: _dbo},
        locator<Singleton>().userModel.id);
    await locator<Singleton>().reloadGlobalUser().whenComplete(() {
      locator<GetNavigation>().back();
    });
  }
}
