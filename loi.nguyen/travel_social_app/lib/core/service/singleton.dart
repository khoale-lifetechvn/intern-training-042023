import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_social_app/core/extension/log.dart';
import 'package:travel_social_app/core/extension/methods.dart';
import 'package:travel_social_app/core/model/base_table.dart';
import 'package:travel_social_app/core/model/emoji_model.dart';
import 'package:travel_social_app/core/model/field_name.dart';
import 'package:travel_social_app/core/model/user_model.dart';
import 'package:travel_social_app/core/service/api.dart';
import 'package:travel_social_app/core/service/api_nosql.dart';
import 'package:travel_social_app/core/service/auth_service.dart';
import 'package:travel_social_app/core/extension/extension.dart';

class Singleton {
  UserModel _userModel = UserModel({});

  final List<UserModel> _listUser = [];

  final List<EmojiModel> _listEmoji = [];
  final List<String> _listIdUsersBlockDidAccount = [];

  UserModel get userModel => _userModel;

  List<UserModel> get listUser => _listUser;
  List<EmojiModel> get listEmoji => _listEmoji;
  List<String> get listIdUsersBlockDidAccount => _listIdUsersBlockDidAccount;

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
    await loadListUser();
    logSuccess('Tải danh sách người dùng thành công');
    await loadUsersBlockDidAccount();
    logSuccess('Tải dữ liệu những người block tài khoản này thành công');
  }

  Future<void> loadEmoji() {
    Api api = Api(BaseTable.emoji);
    return api.getDataCollection().then((value) {
      _listEmoji.clear();
      _listEmoji.addAll(value.toListMap().map((e) => EmojiModel(e)).toList());
    });
  }

  Future<void> loadListUser() {
    Api api = Api(BaseTable.users);
    return api.getDataCollection().then((value) {
      logError(value.toString());
      _listUser.clear();
      _listUser.addAll(value.toListMap().map((e) => UserModel(e)).toList());
    });
  }

  Future<void> loadUsersBlockDidAccount() {
    ApiNosql apiUserBlock = ApiNosql(
        parentTable: BaseTable.blocking,
        parentID: _userModel.id,
        childTable: BaseTable.userBlocking);
    return apiUserBlock.getDataCollection().then((value) {
      _listIdUsersBlockDidAccount.clear();
      _listIdUsersBlockDidAccount.addAll(value
          .toListMap()
          .map((e) => Methods.getString(e, FieldName.id))
          .toList());
    });
  }
}
