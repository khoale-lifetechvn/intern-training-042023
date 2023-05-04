import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_social_app/core/model/base_table.dart';
import 'package:travel_social_app/core/model/post_model.dart';
import 'package:travel_social_app/ui/base/base_controller.dart';
import 'package:travel_social_app/core/extension/extension.dart';

class PostManagerAllController extends BaseController {
  List<PostModel> get list => _data.map((e) => PostModel(e)).toList();
  final List<Map<String, dynamic>> _data = [];

  @override
  void setData(QuerySnapshot<Object?>? value) {
    _data.clear();
    _data.addAll(value.toListMapCustom());
  }

  @override
  Stream<QuerySnapshot<Object?>?>? loadDataStream() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final Query<Map<String, dynamic>> userPostsRef =
        firestore.collectionGroup(BaseTable.userPosts);
    return userPostsRef.snapshots();
  }
}
