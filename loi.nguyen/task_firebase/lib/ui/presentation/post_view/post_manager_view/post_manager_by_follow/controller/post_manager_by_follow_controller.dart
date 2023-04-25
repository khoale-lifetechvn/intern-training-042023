import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_firebase/core/extension/extension.dart';
import 'package:task_firebase/core/model/base_table.dart';
import 'package:task_firebase/core/model/post_model.dart';
import 'package:task_firebase/core/model/user_following_model.dart';
import 'package:task_firebase/core/service/singleton.dart';
import 'package:task_firebase/locator.dart';
import 'package:task_firebase/ui/base/base_controller.dart';

class PostManagerByFollowController extends BaseController {
  Query<Map<String, dynamic>> refUserFollowing =
      FirebaseFirestore.instance.collectionGroup(BaseTable.userFollowing);

  Query<Map<String, dynamic>> refUserPost =
      FirebaseFirestore.instance.collectionGroup(BaseTable.userPosts);

  String get myID => locator<Singleton>().userModel.id;

  final List<UserFollowingModel> _allInfoFollow = [];

  List<UserFollowingModel> get listUserFollowing =>
      _allInfoFollow.where((e) => e.id == myID).toList();

  List<String> get listIdUserFollow =>
      listUserFollowing.map((e) => e.refID).toList();

  List<PostModel> getListPort(QuerySnapshot<Object?>? dataPosts) {
    return dataPosts.toListMapCustom().map((e) => PostModel(e)).where((e) {
      for (var idUser in listIdUserFollow) {
        if (e.refID == idUser) {
          return true;
        }
      }
      return false;
    }).toList();
  }

  @override
  void setData(QuerySnapshot<Object?>? value) {
    super.setData(value);
    _allInfoFollow.addAll(
        value.toListMapCustom().map((e) => UserFollowingModel(e)).toList());
  }

  @override
  Future<QuerySnapshot<Object?>?>? loadData() {
    return refUserFollowing.get();
  }

  Stream<QuerySnapshot<Object?>?>? loadStreamFollowPost() {
    return refUserPost.snapshots();
  }
}
