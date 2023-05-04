import 'package:travel_social_app/core/extension/methods.dart';
import 'package:travel_social_app/core/model/base_model.dart';
import 'package:travel_social_app/core/model/field_name.dart';

//Support for model userFollowing,userBlocking bescause is the same
class SubModel extends BaseModel {
  SubModel(super.data);

  ///ParenID or Id of following
  String get refID => Methods.getString(data, FieldName.refID);
}
