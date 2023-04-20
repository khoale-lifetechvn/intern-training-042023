import 'package:flutter/material.dart';
import 'package:task_firebase/ui/base_widget/lf_button.dart';
import 'package:task_firebase/ui/resources/color_manager.dart';

enum TypeDialog { waring, ask, sucesss, error }

class ADialog {
  static void show(BuildContext context,
      {String? title,
      TypeDialog typeDialog = TypeDialog.error,
      String? content,
      Function()? onClose,
      Function()? onSubmit}) {
    showDialog(
        context: context,
        builder: ((context) => BaseADialog(
              content: content,
              onClose: onClose,
              onSubmit: onSubmit,
              title: title,
              typeDialog: typeDialog,
            )));
  }
}

class BaseADialog extends StatelessWidget {
  final String? title;
  final TypeDialog typeDialog;
  final String? content;
  final VoidCallback? onClose;
  final Function()? onSubmit;

  const BaseADialog(
      {super.key,
      this.title,
      this.typeDialog = TypeDialog.error,
      this.content,
      this.onClose,
      this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          iconDefault,
          const SizedBox(width: 8),
          Text(
            title ?? textDefalt.keys.first,
          ),
        ],
      ),
      content: Text(content ?? textDefalt.values.first, maxLines: null),
      actions: [
        LFButton(
          onPressed: () {
            Navigator.pop(context);
            onClose != null ? onClose!() : null;
          },
          title: 'Close',
        ),
        if (onSubmit != null)
          LFButton(
            onPressed: onSubmit,
          )
      ],
    );
  }
}

extension DefaultValueDialog on BaseADialog {
  Icon get iconDefault {
    switch (typeDialog) {
      case TypeDialog.waring:
        return Icon(
          Icons.warning,
          color: ColorManager.yellow,
        );
      case TypeDialog.ask:
        return Icon(
          Icons.question_mark,
          color: ColorManager.blue,
        );
      case TypeDialog.sucesss:
        return Icon(
          Icons.check,
          color: ColorManager.green,
        );
      case TypeDialog.error:
        return Icon(
          Icons.close,
          color: ColorManager.red,
        );
    }
  }

  Map<String, String> get textDefalt {
    switch (typeDialog) {
      case TypeDialog.waring:
        return {'Cảnh báo': 'Chức năng không phù hợp'};
      case TypeDialog.ask:
        return {'Xác nhận': 'Bạn xác nhận thay đổi không'};
      case TypeDialog.sucesss:
        return {'Thành công': 'Chức năng đã được thực hiện'};
      case TypeDialog.error:
        return {'Lỗi': 'Đã có vấn đề xãy ra'};
    }
  }
}
