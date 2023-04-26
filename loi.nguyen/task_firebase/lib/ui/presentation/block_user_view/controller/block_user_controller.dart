import 'package:task_firebase/core/extension/enum.dart';
import 'package:task_firebase/core/model/base_table.dart';
import 'package:task_firebase/core/service/api.dart';
import 'package:task_firebase/core/service/api_nosql.dart';
import 'package:task_firebase/core/service/get_navigation.dart';
import 'package:task_firebase/core/service/singleton.dart';
import 'package:task_firebase/locator.dart';
import 'package:task_firebase/ui/base_widget/lf_dialog.dart';

class BlockUserController {
  final Api _api = Api(BaseTable.users);

  Stream<List<Map<String, dynamic>>> streamData() {
    return _api.streamDataCollection1N(
        bTable: BaseTable.blocking, bChildTable: BaseTable.userBlocking);
  }

  void updateBlock(String userID) {
    final ApiNosql apiNosql = ApiNosql(
        parentTable: BaseTable.blocking,
        parentID: userID,
        childTable: BaseTable.userBlocking);
    apiNosql.addDocumentNN(id: locator<Singleton>().userModel.id).then((value) {
      if (value == Status.add.name) {
        locator<GetNavigation>().openDialog(
            content: 'Block Successfully', typeDialog: TypeDialog.sucesss);
      } else if (value == Status.remove.name) {
        locator<GetNavigation>().openDialog(
            content: 'UnBlock Successfully', typeDialog: TypeDialog.sucesss);
      } else {
        locator<GetNavigation>().openDialog(content: value);
      }
    });
  }
}
