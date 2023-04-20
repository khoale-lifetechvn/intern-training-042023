import 'package:task_firebase/core/service/auth_service.dart';
import 'package:task_firebase/core/service/get_navigation.dart';
import 'package:task_firebase/locator.dart';
import 'package:task_firebase/ui/base_widget/lf_dialog.dart';
import 'package:task_firebase/ui/resources/routes_manager.dart';

class RegisterController {
  String? _email;
  String? _password;
  String? _name;
  String? _dbo;

  set email(String? value) => _email = value;

  set password(String? value) => _password = value;
  set name(String? value) => _name = value;
  set dbo(String? value) => _dbo = value;

  final AuthenticationService auth = AuthenticationService();

  void signUp() async {
    await auth
        .signUp(
            dbo: _dbo ?? '',
            email: _email ?? '',
            name: _name ?? '',
            password: _password ?? '')
        .then((value) {
      if (value != null) {
        locator<GetNavigation>()
            .openDialog(typeDialog: TypeDialog.error, content: value);
      } else {
        locator<GetNavigation>().openDialog(
          typeDialog: TypeDialog.sucesss,
          content: 'You have successfully registered',
          onClose: () {
            locator<GetNavigation>().replaceTo(RouterPath.login);
          },
        );
      }
    });
  }
}
