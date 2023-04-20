import 'package:flutter/material.dart';
import 'package:task_firebase/ui/resources/color_manager.dart';

typedef CallBackBool = Function(bool);

class MainManagerTggButton extends StatefulWidget {
  const MainManagerTggButton({super.key, required this.onChangeIsDesc});
  final CallBackBool onChangeIsDesc;

  @override
  State<MainManagerTggButton> createState() => _MainManagerTggButtonState();
}

class _MainManagerTggButtonState extends State<MainManagerTggButton> {
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
