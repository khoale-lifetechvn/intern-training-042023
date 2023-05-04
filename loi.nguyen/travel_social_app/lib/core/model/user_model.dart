import 'package:travel_social_app/core/extension/methods.dart';
import 'package:travel_social_app/core/model/base_model.dart';
import 'package:travel_social_app/core/model/base_table.dart';
import 'package:travel_social_app/core/model/field_name.dart';
import 'package:travel_social_app/core/model/sub_model.dart';
import 'package:travel_social_app/core/service/singleton.dart';
import 'package:travel_social_app/locator.dart';

class UserModel extends BaseModel {
  UserModel(super.data);

  String get name => Methods.getString(data, FieldName.name);

  String get showName => name.isEmpty ? 'No Name' : name;

  String get email => Methods.getString(data, FieldName.email);

  DateTime get dbo => Methods.getDateTime(data, FieldName.dbo);

  String get showDbo =>
      Methods.convertTime(Methods.getDateTime(data, FieldName.dbo),
          defaultFormat: 'dd/MM/yyyy');

  List<SubModel> get listUserFollow =>
      Methods.getList(data, BaseTable.userFollowing)
          .map((e) => SubModel(e))
          .toList();

  ///List user did block by this account
  List<SubModel> get listUserBlock =>
      Methods.getList(data, BaseTable.userBlocking)
          .map((e) => SubModel(e))
          .toList();

  String get showImg => super.img.isEmpty
      ? 'https://upload.wikimedia.org/wikipedia/commons/5/54/Deus_reading.png'
      : super.img;

  bool get isFollowThisAccount {
    for (var e in listUserFollow) {
      if (e.id == locator<Singleton>().userModel.id) {
        return true;
      }
    }
    return false;
  }

  bool get isBlockThisAccount {
    for (var e in locator<Singleton>().listIdUsersBlockDidAccount) {
      if (id == e) {
        return true;
      }
    }
    return false;
  }

  bool get isBlock {
    for (var e in listUserBlock) {
      if (e.id == locator<Singleton>().userModel.id) {
        return true;
      }
    }
    return false;
  }
}
