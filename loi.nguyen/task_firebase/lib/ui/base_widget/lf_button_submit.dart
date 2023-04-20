import 'package:flutter/material.dart';
import 'package:task_firebase/ui/resources/color_manager.dart';
import 'package:task_firebase/ui/resources/styles_manager.dart';

class LFButtonSubmit extends StatelessWidget {
  const LFButtonSubmit(
      {super.key, this.text = 'Submit', this.onPressed, this.color});
  final String text;
  final VoidCallback? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
        child: MaterialButton(
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          onPressed: onPressed,
          color: color ?? ColorManager.green,
          child: Text(
            text,
            style: getTitleText(),
          ),
        ),
      ),
    );
  }
}
