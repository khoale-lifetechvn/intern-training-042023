import 'package:travel_social_app/core/extension/enum.dart';
import 'package:travel_social_app/core/model/base_table.dart';
import 'package:travel_social_app/core/service/api.dart';
import 'package:travel_social_app/core/service/api_nosql.dart';
import 'package:travel_social_app/core/service/get_navigation.dart';
import 'package:travel_social_app/core/service/singleton.dart';
import 'package:travel_social_app/locator.dart';
import 'package:travel_social_app/ui/base_widget/lf_dialog.dart';

class FollowUsersController {
  final Api _api = Api(BaseTable.users);

  Stream<List<Map<String, dynamic>>> streamData() {
    return _api.streamDataCollection1N(
        bTable: BaseTable.following, bChildTable: BaseTable.userFollowing);
  }

  void updateFollow(String userID) {
    final ApiNosql apiNosql = ApiNosql(
        parentTable: BaseTable.following,
        parentID: userID,
        childTable: BaseTable.userFollowing);
    apiNosql.addDocumentNN(id: locator<Singleton>().userModel.id).then((value) {
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
}
