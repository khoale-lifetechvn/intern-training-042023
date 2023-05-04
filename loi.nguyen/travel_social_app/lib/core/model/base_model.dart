import 'package:travel_social_app/core/extension/methods.dart';
import 'package:travel_social_app/core/model/field_name.dart';
import 'package:travel_social_app/core/service/singleton.dart';
import 'package:travel_social_app/locator.dart';

class BaseModel {
  BaseModel(this.data);
  final Map<String, dynamic> data;
  String get id => Methods.getString(data, 'id');
  String get createdAt =>
      Methods.convertTime(Methods.getDateTime(data, FieldName.createdAt),
          defaultFormat: 'hh:mm a dd/MM/yyyy');
  String get updatedAt =>
      Methods.convertTime(Methods.getDateTime(data, FieldName.updatedAt),
          defaultFormat: 'dd/MM/yyyy');

  String get img => Methods.getString(data, FieldName.img);

  String get userID => locator<Singleton>().userModel.id;
}
