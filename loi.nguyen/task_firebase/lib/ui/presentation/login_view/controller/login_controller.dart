import 'package:flutter/widgets.dart';
import 'package:task_firebase/core/extension/log.dart';
import 'package:task_firebase/core/service/auth_service.dart';
import 'package:task_firebase/core/service/get_navigation.dart';
import 'package:task_firebase/locator.dart';
import 'package:task_firebase/ui/resources/routes_manager.dart';

class LoginController {
  String? _email;
  String? _password;

  AuthenticationService auth = AuthenticationService();

  set email(String? value) {
    _email = value;
  }

  set password(String? value) {
    _password = value;
  }

  void signIn() async {
    await auth.signIn(_email ?? '', _password ?? '').then((value) {
      if (value == null) {
        locator<GetNavigation>().replaceTo(RouterPath.mainManager);
        logSuccess('Đăng nhập thành công');
      } else {
        locator<GetNavigation>().openDialog(content: value);
      }
    });
  }

  void googleSignIn() async {
    await auth.googleSignIn().then((value) {
      if (value == null) {
        locator<GetNavigation>().replaceTo(RouterPath.mainManager);
      } else {
        locator<GetNavigation>().openDialog(content: value);
      }
    });
  }

  void facebookSignIn() async {
    await auth.facebookSignIn().then((value) {
      if (value == null) {
        locator<GetNavigation>().replaceTo(RouterPath.mainManager);
      } else {
        locator<GetNavigation>().openDialog(content: value);
      }
    });
  }

   void githubSignIn(BuildContext context) async {
    await auth.githubSignIn(context).then((value) {
      if (value == null) {
        locator<GetNavigation>().replaceTo(RouterPath.mainManager);
      } else {
        locator<GetNavigation>().openDialog(content: value);
      }
    });
  }
}
