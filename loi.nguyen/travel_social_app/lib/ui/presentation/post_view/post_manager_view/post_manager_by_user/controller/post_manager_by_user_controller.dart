import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_social_app/core/model/base_table.dart';
import 'package:travel_social_app/core/model/post_model.dart';
import 'package:travel_social_app/core/service/api_nosql.dart';
import 'package:travel_social_app/core/service/singleton.dart';
import 'package:travel_social_app/locator.dart';
import 'package:travel_social_app/ui/base/base_controller.dart';

class PostManagerByUserController extends BaseController {
  final ApiNosql _api = ApiNosql(
      parentTable: BaseTable.posts,
      parentID: locator<Singleton>().userModel.id,
      childTable: BaseTable.userPosts);

  List<PostModel> get list => data
      .map((e) => PostModel({...e, 'refID': locator<Singleton>().userModel.id}))
      .toList();

  @override
  Stream<QuerySnapshot<Object?>?>? loadDataStream() {
    return loadDataStreamByUser();
  }

  Stream<QuerySnapshot<Object?>?>? loadDataStreamByUser() {
    return _api.streamData();
  }
}
