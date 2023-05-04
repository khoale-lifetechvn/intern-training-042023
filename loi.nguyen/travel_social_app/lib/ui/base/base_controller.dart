import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:travel_social_app/core/extension/extension.dart';
import 'package:travel_social_app/core/service/singleton.dart';
import 'package:travel_social_app/locator.dart';

abstract class BaseController extends ChangeNotifier {
  final List<Map<String, dynamic>> _data = [];

  List<Map<String, dynamic>> get data => _data;

  String get userID => locator<Singleton>().userModel.id;

  void clearData() {
    _data.clear();
  }

  void setData(QuerySnapshot<Object?>? value) {
    _data.clear();
    _data.addAll(value.toListMap());
  }

  void reload() {
    clearData();
    notifyListeners();
  }

  Future<QuerySnapshot?>? loadData() {
    return null;
  }

  Stream<QuerySnapshot?>? loadDataStream() {
    return null;
  }
}
