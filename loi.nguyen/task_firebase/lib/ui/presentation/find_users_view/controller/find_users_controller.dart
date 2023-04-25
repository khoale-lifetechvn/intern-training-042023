import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_firebase/core/model/base_table.dart';
import 'package:task_firebase/core/service/api.dart';
import 'package:task_firebase/ui/base/base_controller.dart';

class FindUsersController {
  final Api _api = Api(BaseTable.users);

  Stream<List<Map<String, dynamic>>> streamData() {
    return _api.streamDataCollection1N(
        bTable: BaseTable.following, bChildTable: BaseTable.userFollowing);
  }
}
