import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_firebase/core/model/base_table.dart';
import 'package:task_firebase/core/model/post_model.dart';
import 'package:task_firebase/core/service/api.dart';
import 'package:task_firebase/core/service/singleton.dart';
import 'package:task_firebase/locator.dart';
import 'package:task_firebase/ui/base/base_controller.dart';

class MainManagerByUserController extends BaseController {
  final Api _api = Api(BaseTable.posts);

  List<PostModel> get list => data
      .map((e) => PostModel({...e, 'refID': locator<Singleton>().userModel.id}))
      .toList();

  @override
  Stream<QuerySnapshot<Object?>?>? loadDataStream() {
    return loadDataStreamByUser();
  }

  Stream<QuerySnapshot<Object?>?>? loadDataStreamByUser() {
    return _api.streamDataComplex(
        parentID: locator<Singleton>().userModel.id,
        childTable: BaseTable.userPosts);
  }
}
