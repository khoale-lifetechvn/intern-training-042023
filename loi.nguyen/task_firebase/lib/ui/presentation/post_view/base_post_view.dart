import 'package:flutter/material.dart';

import 'package:task_firebase/ui/base_widget/lf_appbar.dart';

abstract class BasePostView extends StatelessWidget {
  const BasePostView({
    Key? key,
  }) : super(key: key);
  String get titleAppbar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: LFAppBar(title: titleAppbar),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: body,
      ),
    );
  }

  Widget get body;
}
