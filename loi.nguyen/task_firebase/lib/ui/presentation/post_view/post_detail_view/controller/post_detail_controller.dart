import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_firebase/core/extension/log.dart';
import 'package:task_firebase/core/extension/methods.dart';
import 'package:task_firebase/core/model/base_table.dart';
import 'package:task_firebase/core/extension/extension.dart';
import 'package:task_firebase/core/model/field_name.dart';
import 'package:task_firebase/core/model/post_comment_model.dart';
import 'package:task_firebase/core/model/post_model.dart';
import 'package:task_firebase/core/service/api.dart';
import 'package:task_firebase/core/service/api_nosql.dart';
import 'package:task_firebase/core/service/get_navigation.dart';
import 'package:task_firebase/core/service/singleton.dart';
import 'package:task_firebase/locator.dart';
import 'package:task_firebase/ui/base_widget/lf_dialog.dart';

class PostDetailController {
  PostDetailController(this._postModel) {
    _apiPostComment = ApiNosql(
        parentTable: BaseTable.comments,
        parentID: postID,
        childTable: BaseTable.postComments);
  }
  final PostModel _postModel;
  final ApiNosql _api = ApiNosql(
    parentTable: BaseTable.posts,
    parentID: locator<Singleton>().userModel.id,
    childTable: BaseTable.userPosts,
  );

  late ApiNosql _apiPostComment;

  String? _title;
  String? _content;

  set title(String? value) {
    _title = value;
  }

  set content(String? value) {
    _content = value;
  }

  bool get isAuthor => _postModel.refID == locator<Singleton>().userModel.id;

  void updatePost() async {
    await _api.updateData(id: _postModel.id, data: {
      FieldName.title: _title,
      FieldName.content: _content,
    }).then((value) => value.backOrNotification());
  }

  void deletePost() async {
    await _api
        .removeData(_postModel.id)
        .then((value) => value.backOrNotification());
  }

  Future<DocumentSnapshot<Object?>> loadData() {
    Api apiUser = Api(BaseTable.users);
    return apiUser.ref.doc(_postModel.refID).get();
  }

  ///COMMENT
  String get postID => _postModel.id;

  final List<Map<String, dynamic>> _dataComment = [];

  //Get post comment order by desc
  Stream<QuerySnapshot<Object?>> streamComment() {
    return _apiPostComment.ref.orderBy(FieldName.createdAt).snapshots();
  }

  void postCommnet(String comment) {
    _apiPostComment.addData(data: {
      FieldName.userRef: locator<Singleton>().userModel.id,
      FieldName.content: comment
    }).then((value) {
      if (value == null) {
        locator<GetNavigation>().openDialog(
            content: 'Post successfully ^^', typeDialog: TypeDialog.sucesss);
      } else {
        locator<GetNavigation>().openDialog(content: 'Error post $value');
      }
    });
  }

  void setDataComment(QuerySnapshot<Object?>? value) {
    _dataComment.clear();

    List<Map<String, dynamic>> temp = value.toListMapCustom();
    List<Map<String, dynamic>> listUserComment = [];
    for (var eUser in locator<Singleton>().listUser) {
      for (var ePostData in temp) {
        if (eUser.id == Methods.getString(ePostData, FieldName.userRef)) {
          listUserComment.add({...ePostData, BaseTable.users: eUser});
        }
      }
    }
    _dataComment.addAll(listUserComment);
  }

  List<PostCommentModel> get listComment {
    return _dataComment.map((e) => PostCommentModel(e)).toList();
  }
}
