import 'package:travel_social_app/core/model/user_model.dart';
import 'package:travel_social_app/core/service/singleton.dart';
import 'package:travel_social_app/locator.dart';

class ExploreController {
  List<UserModel> get listUser =>
      locator<Singleton>().listUser.take(20).toList();
}
