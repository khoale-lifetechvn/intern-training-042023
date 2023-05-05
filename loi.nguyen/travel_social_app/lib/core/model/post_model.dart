import 'package:travel_social_app/core/extension/methods.dart';
import 'package:travel_social_app/core/extension/extension.dart';
import 'package:travel_social_app/core/model/base_model.dart';
import 'package:travel_social_app/core/model/field_name.dart';
import 'package:travel_social_app/core/service/singleton.dart';
import 'package:travel_social_app/locator.dart';

class PostModel extends BaseModel {
  PostModel(super.data);

  String get title => Methods.getString(data, FieldName.title);
  String get content => Methods.getString(data, FieldName.content);

  ///Id user
  String get refID => Methods.getString(data, FieldName.refID);
  String get showImg => img.isEmpty
      ? 'https://png.pngtree.com/png-vector/20220810/ourmid/pngtree-blogging-concept-picture-writer-laptop-png-image_5722986.png'
      : img;

  ///
  bool get isBlockThisAccount {
    for (var e in locator<Singleton>().listIdUsersBlockDidAccount) {
      if (e == refID) {
        return true;
      }
    }
    return false;
  }

  //
  String get updateDateRelative =>
      Methods.getDateTime(data, FieldName.updatedAt).toRelativeTime();
}
