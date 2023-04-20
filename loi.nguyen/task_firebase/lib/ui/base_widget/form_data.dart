import 'package:flutter/material.dart';
import 'package:task_firebase/ui/base_widget/label.dart';
import 'package:task_firebase/ui/base_widget/lf_button.dart';
import 'package:task_firebase/ui/base_widget/with_spacing.dart';
import 'package:task_firebase/ui/resources/color_manager.dart';
import 'package:task_firebase/ui/resources/values_manager.dart';

class FormData extends StatelessWidget {
  final String? title;
  final Function() onSubmit;
  final String? titleButton;
  final List<Widget> list;
  final bool isFullScreen;

  FormData(
      {super.key,
      this.title,
      this.titleButton,
      this.isFullScreen = false,
      required this.onSubmit,
      required this.list});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.only(
              top: AppPadding.p24,
              bottom: AppPadding.p8,
              left: AppPadding.p12,
              right: AppPadding.p12,
            ),
            decoration: BoxDecoration(
              color: ColorManager.greyForm,
              borderRadius:
                  isFullScreen ? BorderRadius.zero : BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 16), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                ColumnWithSpacing(
                  children: list,
                ),
                SizedBox(height: isFullScreen ? 80 : 8),
                LFButton(
                  onPressed: onSubmitForm,
                )
              ],
            ),
          ),
        ),
        if (title != null)
          Positioned(
            top: -15,
            child: Label(title!),
          )
      ],
    );
  }

  void onSubmitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      onSubmit();
    }
  }
}
