import 'package:flutter/material.dart';
import 'package:travel_social_app/core/model/user_model.dart';
import 'package:travel_social_app/core/service/auth_service.dart';
import 'package:travel_social_app/core/service/get_navigation.dart';
import 'package:travel_social_app/core/service/singleton.dart';
import 'package:travel_social_app/locator.dart';
import 'package:travel_social_app/ui/base_widget/lf_appbar.dart';
import 'package:travel_social_app/ui/base_widget/lf_button_submit.dart';
import 'package:travel_social_app/ui/base_widget/with_spacing.dart';
import 'package:travel_social_app/ui/resources/color_manager.dart';
import 'package:travel_social_app/ui/resources/routes_manager.dart';
import 'package:travel_social_app/ui/resources/styles_manager.dart';

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
  late String _img;
  late UserModel user;

  final AuthenticationService _auth = AuthenticationService();
  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    user = locator<Singleton>().userModel;
    _userName = getText(user.name);
    _email = getText(user.email);
    _dbo = getText(user.showDbo);
    _createdAt = getText(user.createdAt);
    _updatedAt = getText(user.updatedAt);
    _img = user.img.isEmpty
        ? 'https://cdn-icons-png.flaticon.com/512/1946/1946429.png'
        : user.img;
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
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.network(
                _img,
                fit: BoxFit.contain,
                height: 100,
                width: 100,
              ),
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
                  initData();
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
            style: getTitle1Text(),
          ),
          Text(
            'Email: $_email',
            style: getTitle1Text(),
          ),
          Text(
            'Date of birth: $_dbo',
            style: getTitle1Text(),
          ),
          Text(
            'Created at: $_createdAt',
            style: getTitle1Text(),
          ),
          Text(
            'Updated at: $_updatedAt',
            style: getTitle1Text(),
          )
        ]);
  }
}