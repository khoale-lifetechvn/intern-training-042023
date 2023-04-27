//Support for emojiPost and emojiComment
import 'package:task_firebase/core/extension/methods.dart';
import 'package:task_firebase/core/model/base_model.dart';
import 'package:task_firebase/core/model/field_name.dart';

//Support for emojiPost and emojiComment
class ReactionModel extends BaseModel {
  ReactionModel(super.data);

  String get emojiRef => Methods.getString(data, FieldName.emojiRef);

  ///Id user
  String get refID => Methods.getString(data, FieldName.refID);
}
