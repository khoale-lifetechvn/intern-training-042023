import 'package:task_firebase/core/model/base_table.dart';
import 'package:task_firebase/core/model/field_name.dart';
import 'package:task_firebase/core/service/api.dart';
import 'package:task_firebase/core/extension/extension.dart';
import 'package:task_firebase/core/service/singleton.dart';
import 'package:task_firebase/locator.dart';

class MainAddController {
  String? _title;
  String? _content;

  set title(String? value) {
    _title = value;
  }

  set content(String? value) {
    _content = value;
  }

  void addPost() async {
    Api api = Api(BaseTable.posts);
    String uid = locator<Singleton>().userModel.id;
    await api.addDocumentComplex(
        childTable: BaseTable.userPosts,
        parentID: uid,
        data: {
          FieldName.title: _title,
          FieldName.content: _content,
        }).then((value) {
      value.backOrNotification();
    });
  }
}
