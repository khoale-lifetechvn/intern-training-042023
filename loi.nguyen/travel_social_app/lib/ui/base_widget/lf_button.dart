import 'package:flutter/material.dart';
import 'package:travel_social_app/ui/resources/color_manager.dart';
import 'package:travel_social_app/ui/resources/styles_manager.dart';

class LFButton extends StatelessWidget {
  const LFButton(
      {super.key, this.title = 'SUBMIT', this.onPressed, this.color});
  final String title;
  final void Function()? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color ?? ColorManager.green,
      child: Text(
        title,
        style: getLabelText(),
      ),
    );
  }
}
