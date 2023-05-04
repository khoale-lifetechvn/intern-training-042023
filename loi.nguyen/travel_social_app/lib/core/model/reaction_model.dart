//Support for emojiPost and emojiComment
import 'package:travel_social_app/core/extension/methods.dart';
import 'package:travel_social_app/core/model/base_model.dart';
import 'package:travel_social_app/core/model/field_name.dart';

//Support for emojiPost and emojiComment
class ReactionModel extends BaseModel {
  ReactionModel(super.data);

  String get emojiRef => Methods.getString(data, FieldName.emojiRef);

  ///Id user
  String get refID => Methods.getString(data, FieldName.refID);
}
