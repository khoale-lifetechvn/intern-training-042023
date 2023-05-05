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

class EmojiCommentController {
  EmojiCommentController({required this.commentID});
  final String commentID;

  late final ApiGroup _apiEmojiComment = ApiGroup(BaseTable.emojiComment);

  List<Map<String, dynamic>> newData = [];

  List<ReactionModel> get listEmojiComment =>
      newData.map((e) => ReactionModel(e)).toList();

  void setData(QuerySnapshot<Object?>? value) {
    newData.clear();
    newData.addAll(value.toListMapCustom());
  }

  String get userID => locator<Singleton>().userModel.id;

  EmojiModel? get currentEmoji {
    for (var e in listEmojiComment) {
      //Get find by this account
      if (e.refID == userID) {
        return locator<Singleton>()
            .listEmoji
            .firstWhere((eEmoji) => e.emojiRef == eEmoji.id);
      }
    }
    return null;
  }

  late ApiNosql apiCommentEmoji = ApiNosql(
      parentTable: BaseTable.reaction,
      parentID: userID,
      childTable: BaseTable.emojiComment);

  void submitReactionComment({required String emojiId}) {
    bool isRemove = emojiId == currentEmoji?.id;
    apiCommentEmoji
        .handleDocument(
            id: commentID,
            data: {FieldName.emojiRef: emojiId},
            isRemove: isRemove ? true : false)
        .then((value) {
      value.showNotifition(
          addAlert: 'Reaction comment successfully',
          removeAlert: 'UnReaction comment successfully');
    });
  }

  Stream<QuerySnapshot<Object?>?>? loadDataStream() {
    return _apiEmojiComment.ref
        .where(FieldName.selfId, isEqualTo: commentID)
        .orderBy(FieldName.createdAt, descending: true)
        .snapshots();
  }
}