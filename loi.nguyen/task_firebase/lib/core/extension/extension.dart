import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:task_firebase/core/model/field_name.dart';
import 'package:task_firebase/core/model/user_model.dart';
import 'package:task_firebase/core/service/get_navigation.dart';
import 'package:task_firebase/core/service/singleton.dart';
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

extension DateTimeExtensions on DateTime {
  String toRelativeTime() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 0) {
      return DateFormat.yMMMMd().format(this);
    } else if (difference.inHours > 0) {
      final hours = difference.inHours;
      return '$hours hour${hours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      final minutes = difference.inMinutes;
      return '$minutes minute${minutes > 1 ? 's' : ''} ago';
    } else {
      return 'just now';
    }
  }
}

extension RemoveMyself on List<UserModel> {
  List<UserModel> skipThisAccount() {
    removeWhere((e) => e.id == locator<Singleton>().userModel.id);
    return this;
  }
}
