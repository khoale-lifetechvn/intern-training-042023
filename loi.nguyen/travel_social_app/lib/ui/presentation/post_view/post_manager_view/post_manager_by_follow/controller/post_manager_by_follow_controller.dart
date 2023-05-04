import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_social_app/core/extension/extension.dart';
import 'package:travel_social_app/core/model/base_table.dart';
import 'package:travel_social_app/core/model/post_model.dart';
import 'package:travel_social_app/core/model/sub_model.dart';
import 'package:travel_social_app/core/service/singleton.dart';
import 'package:travel_social_app/locator.dart';
import 'package:travel_social_app/ui/base/base_controller.dart';

class PostManagerByFollowController extends BaseController {
  Query<Map<String, dynamic>> refUserFollowing =
      FirebaseFirestore.instance.collectionGroup(BaseTable.userFollowing);

  Query<Map<String, dynamic>> refUserPost =
      FirebaseFirestore.instance.collectionGroup(BaseTable.userPosts);

  String get myID => locator<Singleton>().userModel.id;

  final List<SubModel> _allInfoFollow = [];

  List<SubModel> get listUserFollowing =>
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
    _allInfoFollow
        .addAll(value.toListMapCustom().map((e) => SubModel(e)).toList());
  }

  @override
  Future<QuerySnapshot<Object?>?>? loadData() {
    return refUserFollowing.get();
  }

  Stream<QuerySnapshot<Object?>?>? loadStreamFollowPost() {
    return refUserPost.snapshots();
  }
}
