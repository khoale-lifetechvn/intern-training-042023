import 'package:flutter/material.dart';
import 'package:task_firebase/core/model/user_model.dart';
import 'package:task_firebase/core/service/auth_service.dart';
import 'package:task_firebase/core/service/get_navigation.dart';
import 'package:task_firebase/core/service/singleton.dart';
import 'package:task_firebase/locator.dart';
import 'package:task_firebase/ui/base_widget/lf_appbar.dart';
import 'package:task_firebase/ui/base_widget/lf_button_submit.dart';
import 'package:task_firebase/ui/base_widget/with_spacing.dart';
import 'package:task_firebase/ui/resources/assets_manager.dart';
import 'package:task_firebase/ui/resources/color_manager.dart';
import 'package:task_firebase/ui/resources/routes_manager.dart';
import 'package:task_firebase/ui/resources/styles_manager.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  late String _userName;
  late String _email;
  late String _dbo;
  late String _createdAt;
  late String _updatedAt;
  late UserModel user;

  final AuthenticationService _auth = AuthenticationService();
  @override
  void initState() {
    super.initState();
    user = locator<Singleton>().userModel;
    _userName = getText(user.name);
    _email = getText(user.email);
    _dbo = getText(user.dbo);
    _createdAt = getText(user.createdAt);
    _updatedAt = getText(user.updatedAt);
  }

  String getText(String abc) {
    return abc.isEmpty ? 'NoData' : abc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LFAppBar(
        title: 'Info user',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 80,
              child: Image.asset(ImageAssets.user),
            ),
            const SizedBox(height: 32),
            info()
          ],
        ),
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LFButtonSubmit(
            text: 'Edit',
            color: ColorManager.blue,
            onPressed: () async {
              await locator<GetNavigation>()
                  .to(RouterPath.userDetail)
                  .whenComplete(() {
                setState(() {
                  _userName = locator<Singleton>().userModel.name;
                  _dbo = locator<Singleton>().userModel.dbo;
                });
              });
            },
          ),
          const SizedBox(height: 8),
          LFButtonSubmit(
            text: 'Logout',
            color: ColorManager.red,
            onPressed: () async {
              await _auth.signOut().then((value) {
                locator<GetNavigation>().toLogout();
              });
            },
          )
        ],
      ),
    );
  }

  Widget info() {
    return ColumnWithSpacing(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name: $_userName',
            style: getTitleText(),
          ),
          Text(
            'Email: $_email',
            style: getTitleText(),
          ),
          Text(
            'Date of birth: $_dbo',
            style: getTitleText(),
          ),
          Text(
            'Created at: $_createdAt',
            style: getTitleText(),
          ),
          Text(
            'Updated at: $_updatedAt',
            style: getTitleText(),
          )
        ]);
  }
}
