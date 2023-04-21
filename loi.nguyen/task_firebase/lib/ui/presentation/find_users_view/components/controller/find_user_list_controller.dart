import 'package:task_firebase/core/model/base_table.dart';
import 'package:task_firebase/core/service/api_nosql.dart';
import 'package:task_firebase/core/service/get_navigation.dart';
import 'package:task_firebase/core/service/singleton.dart';
import 'package:task_firebase/locator.dart';
import 'package:task_firebase/ui/base_widget/lf_dialog.dart';

class FindUserListController {
  void updateFollow(String uid) {
    ApiNosql api = ApiNosql(
        parentTable: BaseTable.following,
        parentID: uid,
        childTable: BaseTable.userFollowing);
    api.addDocumentNN(id: locator<Singleton>().userModel.id).then((value) {
      if (value != null) {
        locator<GetNavigation>().openDialog(content: value);
      } else {
        locator<GetNavigation>()
            .openDialog(content: 'Thành công', typeDialog: TypeDialog.sucesss);
      }
    });
  }
}
