import 'package:task_firebase/core/model/base_table.dart';
import 'package:task_firebase/core/model/user_model.dart';
import 'package:task_firebase/core/service/api.dart';

class FindUsersController {
  final Api _api = Api(BaseTable.users);

  Stream<List<Map<String, dynamic>>> streamData() {
    return _api.streamDataCollection1N(
        bTable: BaseTable.following, bChildTable: BaseTable.userFollowing);
  }

}
