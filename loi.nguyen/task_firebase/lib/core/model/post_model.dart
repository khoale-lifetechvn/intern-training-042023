import 'package:task_firebase/core/extension/methods.dart';
import 'package:task_firebase/core/model/base_model.dart';
import 'package:task_firebase/core/model/field_name.dart';
import 'package:task_firebase/core/service/singleton.dart';
import 'package:task_firebase/locator.dart';

class PostModel extends BaseModel {
  PostModel(super.data);

  String get title => Methods.getString(data, FieldName.title);
  String get content => Methods.getString(data, FieldName.content);

  ///Id user
  String get refID => Methods.getString(data, FieldName.refID);

  ///
  bool get isBlockThisAccount {
    for (var e in locator<Singleton>().listIdUsersBlockDidAccount) {
      if (e == refID) {
        return true;
      }
    }
    return false;
  }
}
