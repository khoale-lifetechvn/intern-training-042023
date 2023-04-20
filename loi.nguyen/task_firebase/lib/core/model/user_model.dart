import 'package:task_firebase/core/extension/methods.dart';
import 'package:task_firebase/core/model/base_model.dart';
import 'package:task_firebase/core/model/field_name.dart';

class UserModel extends BaseModel {
  UserModel(super.data);

  String get name => Methods.getString(data, FieldName.name);
  
  String get email => Methods.getString(data, FieldName.email);

  String get dbo => Methods.getString(data, FieldName.dbo);

}
