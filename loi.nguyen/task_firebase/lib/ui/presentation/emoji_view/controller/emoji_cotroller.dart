import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_firebase/core/extension/methods.dart';
import 'package:task_firebase/core/model/base_table.dart';
import 'package:task_firebase/core/model/emoji_model.dart';
import 'package:task_firebase/core/model/field_name.dart';
import 'package:task_firebase/core/service/api.dart';
import 'package:task_firebase/ui/base/base_controller.dart';

class EmojiController extends BaseController {
  Api apiEmoji = Api(BaseTable.emoji);

  List<EmojiModel> get listEmoji {
    return data.map((e) => EmojiModel(e)).toList();
  }

  @override
  void setData(QuerySnapshot<Object?>? value) {
    super.setData(value);
    data.sort((a, b) => Methods.getInt(a, FieldName.index)
        .compareTo(Methods.getInt(b, FieldName.index)));
  }

  

  @override
  Stream<QuerySnapshot<Object?>?>? loadDataStream() {
    return apiEmoji.streamDataCollection();
  }
}
