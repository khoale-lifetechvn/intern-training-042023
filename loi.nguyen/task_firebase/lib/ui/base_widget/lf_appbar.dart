import 'package:flutter/material.dart';
import 'package:task_firebase/ui/resources/color_manager.dart';
import 'package:task_firebase/ui/resources/styles_manager.dart';

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
                  style: getTitleText(color: ColorManager.white),
                ),
                if (suffix != null) suffix
              ],
            ),
            backgroundColor: ColorManager.greyBG);
}
