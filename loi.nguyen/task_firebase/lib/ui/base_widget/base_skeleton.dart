import 'package:flutter/material.dart';
import 'package:task_firebase/ui/resources/color_manager.dart';
import 'package:task_firebase/ui/resources/styles_manager.dart';

class BaseSkeleton extends StatelessWidget {
  const BaseSkeleton({super.key, required this.content, this.color});
  final String content;
  final Color? color;

  Color get colorData => color ?? ColorManager.greyForm;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircularProgressIndicator(
            backgroundColor: colorData,
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: getTitleText(color: colorData),
          )
        ],
      ),
    );
  }
}
