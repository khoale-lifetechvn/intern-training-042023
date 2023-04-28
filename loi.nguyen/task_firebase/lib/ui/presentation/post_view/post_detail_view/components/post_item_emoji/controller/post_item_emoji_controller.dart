import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_firebase/core/extension/extension.dart';
import 'package:task_firebase/core/model/base_table.dart';
import 'package:task_firebase/core/model/emoji_model.dart';
import 'package:task_firebase/core/model/field_name.dart';
import 'package:task_firebase/core/model/reaction_model.dart';
import 'package:task_firebase/core/service/api_group.dart';
import 'package:task_firebase/core/service/api_nosql.dart';
import 'package:task_firebase/core/service/get_navigation.dart';
import 'package:task_firebase/core/service/singleton.dart';
import 'package:task_firebase/locator.dart';
import 'package:task_firebase/ui/base/base_controller.dart';
import 'package:task_firebase/ui/base_widget/lf_dialog.dart';

class PostItemEmojiController extends BaseController {
  PostItemEmojiController({required this.postID});
  final String postID;

  late final ApiGroup _apiEmojiPost = ApiGroup(BaseTable.emojiPost);

  List<Map<String, dynamic>> newData = [];

  List<ReactionModel> get listEmojiPost =>
      newData.map((e) => ReactionModel(e)).toList();

  @override
  void setData(QuerySnapshot<Object?>? value) {
    newData.clear();
    newData.addAll(value.toListMapCustom());
  }

  EmojiModel? get currentEmoji {
    for (var e in listEmojiPost) {
      //Get find by this account
      if (e.refID == userID) {
        return locator<Singleton>()
            .listEmoji
            .firstWhere((eEmoji) => e.emojiRef == eEmoji.id);
      }
    }
    return null;
  }

  late ApiNosql apiPostEmoji = ApiNosql(
      parentTable: BaseTable.reaction,
      parentID: userID,
      childTable: BaseTable.emojiPost);

  void submitReaction({required String emojiId}) {
    apiPostEmoji
        .handleDocument(
            id: postID,
            data: {FieldName.emojiRef: emojiId},
            isRemove: emojiId == 'remove' ? true : false)
        .then((value) {
      if (value == null) {
        locator<GetNavigation>().openDialog(
            content: 'Reaction successfully', typeDialog: TypeDialog.sucesss);
      } else {
        locator<GetNavigation>().openDialog(content: value);
      }
    });
  }

  // @override
  @override
  Stream<QuerySnapshot<Object?>?>? loadDataStream() {
    return _apiEmojiPost.ref.where('postId', isEqualTo: postID).snapshots();
  }
}
// FieldPath.documentId