import 'dart:io';

import 'package:travel_social_app/core/model/base_table.dart';
import 'package:travel_social_app/core/model/field_name.dart';
import 'package:travel_social_app/core/model/user_model.dart';
import 'package:travel_social_app/core/service/api.dart';
import 'package:travel_social_app/core/service/get_navigation.dart';
import 'package:travel_social_app/core/service/singleton.dart';
import 'package:travel_social_app/locator.dart';

class UserDetailController {
  final Api _api = Api(BaseTable.users);

  String? _name;
  DateTime? _dbo;
  File? _file;

  UserModel get user => locator<Singleton>().userModel;

  set name(String? value) {
    _name = value;
  }

  set dbo(DateTime? value) {
    _dbo = value;
  }

  set file(File? value) {
    _file = value;
  }

  void updateUser() async {
    await _api.updateDocument({
      FieldName.name: _name,
      FieldName.dbo: _dbo,
    }, locator<Singleton>().userModel.id, file: _file);
    await locator<Singleton>().reloadGlobalUser().whenComplete(() {
      locator<GetNavigation>().back();
    });
  }
}
