import 'package:flutter/material.dart';
import 'package:task_firebase/ui/resources/assets_manager.dart';
import 'package:task_firebase/ui/resources/color_manager.dart';

class TitleLogoItem extends StatelessWidget {
  const TitleLogoItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'QUIZ',
          style: TextStyle(
            color: ColorManager.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Image.asset(
          ImageAssets.logo,
          width: 200,
          height: 200,
        )
      ],
    );
  }
}
