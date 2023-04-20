import 'package:task_firebase/core/extension/methods.dart';
import 'package:task_firebase/core/model/base_model.dart';
import 'package:task_firebase/core/model/field_name.dart';

class PostModel extends BaseModel {
  PostModel(super.data);

  String get title => Methods.getString(data, FieldName.title);
  String get content => Methods.getString(data, FieldName.content);
  String get refID => Methods.getString(data, FieldName.refID);


}
