import 'package:flutter/material.dart';
import 'package:task_firebase/ui/resources/color_manager.dart';
import 'package:task_firebase/ui/resources/values_manager.dart';

class Label extends StatelessWidget {
  final EdgeInsets? padding;
  final String text;
  const Label(this.text, {super.key, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsets.symmetric(
              vertical: AppPadding.p4, horizontal: AppPadding.p30),
      decoration: BoxDecoration(
        color: ColorManager.green,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Text(
        text,
        style:
            TextStyle(color: ColorManager.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
