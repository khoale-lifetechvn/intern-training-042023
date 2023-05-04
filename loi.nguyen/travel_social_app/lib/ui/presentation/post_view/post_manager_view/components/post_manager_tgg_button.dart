import 'package:flutter/material.dart';
import 'package:travel_social_app/ui/resources/color_manager.dart';

typedef CallBackBool = Function(bool);

class PostManagerTggButton extends StatefulWidget {
  const PostManagerTggButton({super.key, required this.onChangeIsDesc});
  final CallBackBool onChangeIsDesc;

  @override
  State<PostManagerTggButton> createState() => _PostManagerTggButtonState();
}

class _PostManagerTggButtonState extends State<PostManagerTggButton> {
  // one must always be true, means selected.
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
        borderColor: ColorManager.green,
        isSelected: isSelected,
        borderRadius: BorderRadius.circular(16),
        onPressed: (int newIndex) {
          setState(() {
            // looping through the list of booleans values
            for (int index = 0; index < isSelected.length; index++) {
              if (index == newIndex) {
                isSelected[index] = true;
              } else {
                // other two will be set to false and not selected
                isSelected[index] = false;
              }
            }
          });
          widget.onChangeIsDesc(isSelected.last);
        },
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text('Increase', style: TextStyle(fontSize: 18)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text('Descrease', style: TextStyle(fontSize: 18)),
          ),
        ]);
  }
}
