import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_firebase/core/extension/log.dart';
import 'package:task_firebase/core/model/base_table.dart';
import 'package:task_firebase/core/model/emoji_model.dart';
import 'package:task_firebase/core/model/user_model.dart';
import 'package:task_firebase/core/service/api.dart';
import 'package:task_firebase/core/service/auth_service.dart';
import 'package:task_firebase/core/extension/extension.dart';
import 'package:task_firebase/locator.dart';

class Singleton {
  UserModel _userModel = UserModel({});

  final List<UserModel> _listUser = [];

  final List<EmojiModel> _listEmoji = [];

  UserModel get userModel => _userModel;

  List<UserModel> get listUser => _listUser;
  List<EmojiModel> get listEmoji => _listEmoji;

  Future<QuerySnapshot> loadListUser() {
    Api api = Api(BaseTable.users);
    return api.getDataCollection();
  }

  set listUser(List<UserModel> list) {
    _listUser.clear();
    _listUser.addAll(list);
  }

  Future<void> reloadGlobalUser() async {
    Api api = Api(BaseTable.users);
    User? user = AuthenticationService().getCurrentUser();
    var data = await api.ref.doc(user!.uid).get();

    _userModel = UserModel(data.toMap());
    logSuccess('Reload lại data global user thành công');
  }

  Future<void> loadDefaultData() async {
    await loadEmoji();
    logSuccess('Tải dữ liệu emoji thành công');
    await loadUser();
    logSuccess('Tải dữ liệu người dùng thành công');
  }

  Future<void> loadEmoji() {
    Api api = Api(BaseTable.emoji);
    return api.getDataCollection().then((value) {
      _listEmoji.clear();
      _listEmoji.addAll(value.toListMap().map((e) => EmojiModel(e)).toList());
    });
  }

  Future<void> loadUser() {
    Api api = Api(BaseTable.users);
    return api.getDataCollection().then((value) {
      _listUser.clear();
      _listUser.addAll(value.toListMap().map((e) => UserModel(e)).toList());
    });
  }
}
