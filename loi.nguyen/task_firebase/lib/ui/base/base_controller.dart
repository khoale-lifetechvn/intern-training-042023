import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';


abstract class BaseController extends ChangeNotifier {
  final List<Map<String, dynamic>> _data = [];

  List<Map<String, dynamic>> get data => _data;

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

extension QuerySnapshotToList on QuerySnapshot<Object?>? {
  List<Map<String, dynamic>> toListMap() {
    List<Map<String, dynamic>> temp = [];
    if (this != null) {
      for (var e in this!.docs) {
        Map<String, dynamic> currentValue = e.data() as Map<String, dynamic>;
        currentValue['id'] = e.id;
        temp.add(currentValue);
      }
    }
    return temp;
  }
}