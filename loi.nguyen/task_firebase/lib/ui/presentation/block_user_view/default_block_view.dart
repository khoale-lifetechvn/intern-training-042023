import 'package:flutter/material.dart';
import 'package:task_firebase/core/service/get_navigation.dart';
import 'package:task_firebase/locator.dart';
import 'package:task_firebase/ui/base_widget/lf_appbar.dart';
import 'package:task_firebase/ui/base_widget/lf_button.dart';
import 'package:task_firebase/ui/resources/color_manager.dart';
import 'package:task_firebase/ui/resources/styles_manager.dart';

class DefaultBlockView extends StatelessWidget {
  const DefaultBlockView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LFAppBar(title: 'Oops'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'You don\'t have permission read this page',
            style: getTitleText(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Image.network(
            'https://cdn-icons-png.flaticon.com/512/81/81052.png',
          ),
          LFButton(
            color: ColorManager.blue,
            onPressed: () {
              locator<GetNavigation>().back();
            },
            title: 'Go Back',
          ),
        ],
      ),
    );
  }
}
