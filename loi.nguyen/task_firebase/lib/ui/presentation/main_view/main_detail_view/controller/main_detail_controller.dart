import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_firebase/core/model/base_table.dart';
import 'package:task_firebase/core/model/field_name.dart';
import 'package:task_firebase/core/model/post_model.dart';
import 'package:task_firebase/core/service/api.dart';
import 'package:task_firebase/core/service/singleton.dart';
import 'package:task_firebase/locator.dart';
import 'package:task_firebase/core/extension/extension.dart';

class MainDetailController {
  MainDetailController(this._postModel);
  final PostModel _postModel;
  final Api _api = Api(BaseTable.posts);

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
    await _api.updateDocumentComplex(
        parentID: locator<Singleton>().userModel.id,
        childTable: BaseTable.userPosts,
        childID: _postModel.id,
        data: {
          FieldName.title: _title,
          FieldName.content: _content,
        }).then((value) => value.backOrNotification());
  }

  Future<DocumentSnapshot<Object?>> loadData() {
    Api apiUser = Api(BaseTable.users);
    return apiUser.ref.doc(_postModel.refID).get();
  }
}
