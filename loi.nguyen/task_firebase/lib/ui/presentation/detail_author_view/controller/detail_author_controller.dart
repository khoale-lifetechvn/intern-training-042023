import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_firebase/core/extension/enum.dart';
import 'package:task_firebase/core/model/base_table.dart';
import 'package:task_firebase/core/model/sub_model.dart';
import 'package:task_firebase/core/service/api_nosql.dart';
import 'package:task_firebase/core/service/get_navigation.dart';
import 'package:task_firebase/core/service/singleton.dart';
import 'package:task_firebase/locator.dart';
import 'package:task_firebase/ui/base/base_controller.dart';
import 'package:task_firebase/ui/base_widget/lf_dialog.dart';

class DetailAuthorController extends BaseController {
  DetailAuthorController(this.userIDAuthor) {
    _apiNosql = ApiNosql(
        parentTable: BaseTable.following,
        parentID: userIDAuthor,
        childTable: BaseTable.userFollowing);
  }
  final String userIDAuthor;

  late ApiNosql _apiNosql;

  List<SubModel> get listIdUserFollow => data.map((e) => SubModel(e)).toList();

  bool get isFollow {
    for (var e in listIdUserFollow) {
      if (e.id == locator<Singleton>().userModel.id) {
        return true;
      }
    }
    return false;
  }

  @override
  Stream<QuerySnapshot<Object?>?>? loadDataStream() {
    return _apiNosql.streamData();
  }

  void updateFollow() {
    _apiNosql
        .addDocumentNN(id: locator<Singleton>().userModel.id)
        .then((value) {
      if (value == Status.add.name) {
        locator<GetNavigation>().openDialog(
            content: 'Follow Successfully', typeDialog: TypeDialog.sucesss);
      } else if (value == Status.remove.name) {
        locator<GetNavigation>().openDialog(
            content: 'Unfollow Successfully', typeDialog: TypeDialog.sucesss);
      } else {
        locator<GetNavigation>().openDialog(content: value);
      }
    });
  }

  //----------------------------------------//
}
