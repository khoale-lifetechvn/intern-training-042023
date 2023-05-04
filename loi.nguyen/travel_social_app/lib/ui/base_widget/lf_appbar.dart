import 'package:flutter/material.dart';
import 'package:travel_social_app/ui/resources/color_manager.dart';
import 'package:travel_social_app/ui/resources/styles_manager.dart';

class LFAppBar extends AppBar {
  LFAppBar({
    super.key,
    super.bottom,
    required String title,
    Widget? suffix,
  }) : super(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title.toUpperCase(),
                  style: getTitle1Text(color: ColorManager.white),
                ),
                if (suffix != null) suffix
              ],
            ),
            backgroundColor: ColorManager.greyBG);
}
