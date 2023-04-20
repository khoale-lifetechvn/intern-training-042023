import 'package:task_firebase/core/extension/methods.dart';
import 'package:task_firebase/core/model/field_name.dart';

class BaseModel {
  BaseModel(this.data);
  final Map<String, dynamic> data;
  String get id => Methods.getString(data, 'id');
  String get createdAt =>
      Methods.convertTime(Methods.getDateTime(data, FieldName.createdAt),
          defaultFormat: 'hh:mm a dd/MM/yyyy');
  String get updatedAt =>
      Methods.convertTime(Methods.getDateTime(data, FieldName.updatedAt),
          defaultFormat: 'hh:mm a dd/MM/yyyy');

  String get img => Methods.getString(data, FieldName.img);
}
