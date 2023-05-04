import 'package:flutter/material.dart';
import 'package:travel_social_app/core/model/emoji_model.dart';
import 'package:travel_social_app/ui/base_widget/form_data.dart';
import 'package:travel_social_app/ui/base_widget/lf_appbar.dart';
import 'package:travel_social_app/ui/base_widget/lf_form_picker.dart';
import 'package:travel_social_app/ui/base_widget/lf_text_field.dart';
import 'package:travel_social_app/ui/presentation/emoji_view/emoji_detail_view/controller/emojs_detail_controller.dart';
import 'package:travel_social_app/ui/resources/color_manager.dart';

class EmojiDetailView extends StatelessWidget {
  EmojiDetailView({super.key, this.model});

  final EmojiModel? model;
  late final EmojiDetailController controller =
      EmojiDetailController(model: model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LFAppBar(title: textAppBar),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormData(
              onSubmit: () {
                controller.submit();
              },
              list: listTextField),
          if (!controller.isAddData) ...[moreData()]
        ],
      ),
    );
  }

  Widget moreData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          color: ColorManager.greyForm,
          height: 16,
        ),
        Text('Created at: ${model!.createdAt}'),
        const SizedBox(height: 16),
        Text('Updated at: ${model!.updatedAt}')
      ],
    );
  }

  List<Widget> get listTextField => [
        LFTextFormField(
            label: 'Title',
            onSaved: (p0) => controller.title = p0,
            initValue: model?.title),
        LFTextFormField(
            label: 'Index',
            keyboardType: TextInputType.number,
            onSaved: (p0) => controller.index = p0,
            initValue: model?.index.toString()),
        LFFormPicker(
            onSaved: (p0) => controller.file = p0, urlInit: model?.img),
      ];

  String get textAppBar => controller.isAddData ? 'Add Emoji' : 'Update Emoji';
}
