import 'package:flutter/material.dart';
import 'package:travel_social_app/ui/resources/color_manager.dart';
import 'package:travel_social_app/ui/resources/styles_manager.dart';

class BaseSkeleton extends StatelessWidget {
  const BaseSkeleton({super.key, required this.content, this.color});
  final String content;
  final Color? color;

  Color get colorData => color ?? ColorManager.greyForm;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            backgroundColor: colorData,
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: getTitle1Text(color: colorData),
          )
        ],
      ),
    );
  }
}
