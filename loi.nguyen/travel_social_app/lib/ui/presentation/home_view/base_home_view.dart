import 'package:flutter/material.dart';
import 'package:travel_social_app/core/service/singleton.dart';
import 'package:travel_social_app/locator.dart';
import 'package:travel_social_app/ui/base_widget/search_item.dart';
import 'package:travel_social_app/ui/screens/profile.dart';

abstract class BaseHomeView extends StatelessWidget {
  const BaseHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: buildBody(context)),
    );
  }

  Widget buildBody(BuildContext context);

  AppBar appBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      leading: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 16),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const Profile(),
              ),
            );
          },
          child: CircleAvatar(
            radius: 23,
            backgroundColor: Colors.red,
            backgroundImage:
                NetworkImage(locator<Singleton>().userModel.showImg),
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        child: SearchItem(onChanged: (v) {}),
      ),
    );
  }
}
