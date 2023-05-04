import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_social_app/core/model/base_table.dart';
import 'package:travel_social_app/core/model/post_model.dart';
import 'package:travel_social_app/core/service/api_nosql.dart';
import 'package:travel_social_app/ui/base/base_controller.dart';

class ListPostUserController extends BaseController {
  ListPostUserController(this.userIDAuthor);
  final String userIDAuthor;
  late final ApiNosql _apiPosts = ApiNosql(
      parentTable: BaseTable.posts,
      parentID: userIDAuthor,
      childTable: BaseTable.userPosts);

  List<PostModel> get listPosts => data.map((e) => PostModel(e)).toList();

  @override
  Stream<QuerySnapshot<Object?>?>? loadDataStream() {
    return _apiPosts.streamData();
  }
}
