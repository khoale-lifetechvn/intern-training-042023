import 'package:task_firebase/core/model/base_table.dart';
import 'package:task_firebase/core/model/field_name.dart';
import 'package:task_firebase/core/extension/extension.dart';
import 'package:task_firebase/core/service/api_nosql.dart';
import 'package:task_firebase/core/service/singleton.dart';
import 'package:task_firebase/locator.dart';

class PostAddController {
  String? _title;
  String? _content;

  set title(String? value) {
    _title = value;
  }

  set content(String? value) {
    _content = value;
  }

  ApiNosql api = ApiNosql(
      parentTable: BaseTable.posts,
      childTable: BaseTable.userPosts,
      parentID: locator<Singleton>().userModel.id);

  void addPost() async {
    await api.addData(data: {
      FieldName.title: _title,
      FieldName.content: _content,
    }).then((value) {
      value.backOrNotification();
    });
  }
}
