import 'package:flutter/material.dart';

import 'package:task_firebase/ui/base_widget/lf_appbar.dart';

abstract class BasePostView extends StatelessWidget {
  BasePostView({
    Key? key,
  }) : super(key: key);
  String get titleAppbar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LFAppBar(title: titleAppbar),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: body,
        ),
      ),
      bottomSheet: bottomSheet,
    );
  }

 late  Widget? bottomSheet;

  Widget get body;
}
