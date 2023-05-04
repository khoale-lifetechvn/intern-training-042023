import 'package:flutter/material.dart';
import 'package:travel_social_app/ui/resources/assets_manager.dart';
import 'package:travel_social_app/ui/resources/color_manager.dart';

class TitleLogoItem extends StatelessWidget {
  const TitleLogoItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Travel',
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
