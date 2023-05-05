import 'dart:io';

import 'package:travel_social_app/core/model/base_table.dart';
import 'package:travel_social_app/core/model/field_name.dart';
import 'package:travel_social_app/core/extension/extension.dart';
import 'package:travel_social_app/core/service/api_nosql.dart';
import 'package:travel_social_app/core/service/singleton.dart';
import 'package:travel_social_app/locator.dart';

class ManagerPostController {
  String? _title;
  String? _content;
  File? _file;

  set title(String? value) {
    _title = value;
  }

  set content(String? value) {
    _content = value;
  }

  set file(File? value) {
    _file = value;
  }

  ApiNosql api = ApiNosql(
      parentTable: BaseTable.posts,
      childTable: BaseTable.userPosts,
      parentID: locator<Singleton>().userModel.id);

  void addPost() async {
    await api.addData(data: {
      FieldName.title: _title,
      FieldName.content: _content,
    }, file: _file).then((value) {
      value.backOrNotification(
          content: 'You did post successfully', isPopScreen: false);
    });
  }

  void deletePost(String postId) async {
    await api.removeData(postId).then((value) => value.backOrNotification(
        content: 'Delete post successfully', isPopScreen: false));
  }

  void updatePost(String postId) async {
    await api
        .updateData(
            id: postId,
            data: {
              FieldName.title: _title,
              FieldName.content: _content,
            },
            file: _file)
        .then((value) => value.backOrNotification(
            content: 'Update post successfully', isPopScreen: false));
  }
}
