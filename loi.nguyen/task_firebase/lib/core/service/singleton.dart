import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_firebase/core/extension/log.dart';
import 'package:task_firebase/core/model/base_table.dart';
import 'package:task_firebase/core/model/user_model.dart';
import 'package:task_firebase/core/service/api.dart';
import 'package:task_firebase/core/service/auth_service.dart';
import 'package:task_firebase/core/extension/extension.dart';

class Singleton {
  UserModel _userModel = UserModel({});

  UserModel get userModel => _userModel;

  Future<void> reloadGlobalUser() async {
    Api api = Api(BaseTable.users);
    User? user = AuthenticationService().getCurrentUser();
    var data = await api.ref.doc(user!.uid).get();

    _userModel = UserModel(data.toMap());
    logSuccess('Reload lại data global user thành công');
  }

  
}
