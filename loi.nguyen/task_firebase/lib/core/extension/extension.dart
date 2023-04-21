import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_firebase/core/model/field_name.dart';
import 'package:task_firebase/core/service/get_navigation.dart';
import 'package:task_firebase/locator.dart';

extension CallBackAPI on String? {
  //Try if turn back screen previous
  void backOrNotification() {
    if (this == null) {
      locator<GetNavigation>().back();
    } else {
      locator<GetNavigation>().openDialog(content: this);
    }
  }
}

extension CopnvertDocument on DocumentSnapshot<Object?> {
  Map<String, dynamic> toMap() {
    Map<String, dynamic> temp = {};
    temp[FieldName.id] = id;
    temp.addAll(data() as Map<String, dynamic>);
    return temp;
  }
}

extension QuerySnapshotToList on QuerySnapshot<Object?>? {
  List<Map<String, dynamic>> toListMapCustom() {
    List<Map<String, dynamic>> temp = [];
    if (this != null) {
      for (var e in this!.docs) {
        Map<String, dynamic> currentValue = e.data() as Map<String, dynamic>;
        currentValue['id'] = e.id;
        //UserID
        currentValue['refID'] = e.reference.parent.parent!.id;
        temp.add(currentValue);
      }
    }
    return temp;
  }
}

