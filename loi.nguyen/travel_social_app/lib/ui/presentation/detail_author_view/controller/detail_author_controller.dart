import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_social_app/core/extension/enum.dart';
import 'package:travel_social_app/core/model/base_table.dart';
import 'package:travel_social_app/core/model/sub_model.dart';
import 'package:travel_social_app/core/service/api_nosql.dart';
import 'package:travel_social_app/core/service/get_navigation.dart';
import 'package:travel_social_app/core/service/singleton.dart';
import 'package:travel_social_app/locator.dart';
import 'package:travel_social_app/ui/base/base_controller.dart';
import 'package:travel_social_app/ui/base_widget/lf_dialog.dart';

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
