import 'package:travel_social_app/core/service/auth_service.dart';
import 'package:travel_social_app/core/service/get_navigation.dart';
import 'package:travel_social_app/locator.dart';
import 'package:travel_social_app/ui/base_widget/lf_dialog.dart';
import 'package:travel_social_app/ui/resources/routes_manager.dart';

class RegisterController {
  String? _email;
  String? _password;
  String? _name;
  DateTime? _dbo;

  set email(String? value) => _email = value;

  set password(String? value) => _password = value;
  set name(String? value) => _name = value;
  set dbo(DateTime? value) => _dbo = value;

  final AuthenticationService auth = AuthenticationService();

  void signUp() async {
    await auth
        .signUp(
            dbo: _dbo ?? DateTime.now(),
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
            locator<GetNavigation>().toAndRemoveUntil(RouterPath.home);
          },
        );
      }
    });
  }
}
