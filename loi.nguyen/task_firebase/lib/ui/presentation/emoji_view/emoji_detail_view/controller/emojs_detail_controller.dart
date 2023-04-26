import 'dart:io';

import 'package:task_firebase/core/model/base_table.dart';
import 'package:task_firebase/core/model/emoji_model.dart';
import 'package:task_firebase/core/model/field_name.dart';
import 'package:task_firebase/core/service/api.dart';
import 'package:task_firebase/core/extension/extension.dart';

class EmojiDetailController {
  EmojiDetailController({required this.model});
  final EmojiModel? model;

  bool get isAddData => model == null ? true : false;
  final Api _apiEmoji = Api(BaseTable.emoji);
  String? _title;
  String? _index;
  File? _file;

  set title(String? value) {
    _title = value;
  }

  set index(String? value) {
    _index = value;
  }

  set file(File? value) {
    _file = value;
  }

  void submit() {
    isAddData ? _addEmoji() : _updateEmoji();
  }

  void _addEmoji() {
    _apiEmoji.addDocument({
      FieldName.title: _title,
      FieldName.index: int.parse(_index.toString()),
    }, file: _file).then((value) => value.backOrNotification());
  }

  void _updateEmoji() {
    _apiEmoji.updateDocument({
      FieldName.title: _title,
      FieldName.index: int.parse(_index.toString()),
    }, model!.id, file: _file).then((value) => value.backOrNotification());
  }
}
