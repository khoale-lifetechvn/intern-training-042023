import 'package:flutter/material.dart';
import 'package:travel_social_app/ui/base_widget/label.dart';
import 'package:travel_social_app/ui/base_widget/lf_button.dart';
import 'package:travel_social_app/ui/base_widget/with_spacing.dart';
import 'package:travel_social_app/ui/resources/color_manager.dart';
import 'package:travel_social_app/ui/resources/values_manager.dart';

class FormData extends StatelessWidget {
  final String? title;
  final Function() onSubmit;
  final String? titleButton;
  final List<Widget> list;
  final bool isFullScreen;
  final bool disable;
  final Function()? onDelete;

  FormData(
      {super.key,
      this.title,
      this.titleButton,
      this.onDelete,
      this.isFullScreen = false,
      this.disable = false,
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
              borderRadius:
                  isFullScreen ? BorderRadius.zero : BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                ColumnWithSpacing(
                  children: list,
                ),
                SizedBox(height: isFullScreen ? 80 : 8),
                if (!disable) ...[
                  onDelete == null
                      ? LFButton(
                          onPressed: onSubmitForm,
                        )
                      : delete()
                ]
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

  Widget delete() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        LFButton(
          onPressed: onSubmitForm,
        ),
        LFButton(
          onPressed: onDelete,
          title: 'Delete',
          color: ColorManager.red,
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