import 'package:task_firebase/core/extension/methods.dart';
import 'package:task_firebase/core/model/base_model.dart';
import 'package:task_firebase/core/model/field_name.dart';

class EmojiModel extends BaseModel {
  EmojiModel(super.data);
  int get index => Methods.getInt(data, FieldName.index);
  String get title => Methods.getString(data, FieldName.title);
}
