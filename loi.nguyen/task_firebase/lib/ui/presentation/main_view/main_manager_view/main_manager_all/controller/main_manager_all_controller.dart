import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_firebase/core/model/base_table.dart';
import 'package:task_firebase/core/model/post_model.dart';
import 'package:task_firebase/ui/base/base_controller.dart';

class MainManagerAllController extends BaseController {
  List<PostModel> get list => _data.map((e) => PostModel(e)).toList();
  final List<Map<String, dynamic>> _data = [];

  @override
  void setData(QuerySnapshot<Object?>? value) {
    _data.clear();
    _data.addAll(value.toListMapCustom());
  }

  @override
  Future<QuerySnapshot<Object?>?>? loadData() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final Query<Map<String, dynamic>> userPostsRef =
        firestore.collectionGroup(BaseTable.userPosts);
    return userPostsRef.get();
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
