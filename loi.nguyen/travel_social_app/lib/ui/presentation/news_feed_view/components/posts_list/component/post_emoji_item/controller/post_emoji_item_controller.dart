import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_social_app/core/extension/extension.dart';
import 'package:travel_social_app/core/model/base_table.dart';
import 'package:travel_social_app/core/model/emoji_model.dart';
import 'package:travel_social_app/core/model/field_name.dart';
import 'package:travel_social_app/core/model/reaction_model.dart';
import 'package:travel_social_app/core/service/api_group.dart';
import 'package:travel_social_app/core/service/api_nosql.dart';
import 'package:travel_social_app/core/service/singleton.dart';
import 'package:travel_social_app/locator.dart';
import 'package:travel_social_app/ui/base/base_controller.dart';

class PostEmojiItemController extends BaseController {
  PostEmojiItemController({required this.postID});
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
      value.showNotifition(
          addAlert: 'Reaction post successfully',
          removeAlert: 'UnReaction post successfully');
    });
  }

  @override
  Stream<QuerySnapshot<Object?>?>? loadDataStream() {
    return _apiEmojiPost.ref
        .where(FieldName.selfId, isEqualTo: postID)
        .orderBy(FieldName.createdAt, descending: true)
        .snapshots();
  }
}
