import 'package:flutter/material.dart';
import 'package:task_firebase/ui/resources/color_manager.dart';

class LFTextFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final String label;
  final bool obscureText;
   final bool disable;
  final TextInputType? keyboardType;
  final String? initValue;
  final int? maxLines;
  final String hintText;
  final String? Function(String?)? onSaved;
  final void Function(String)? onChanged;

  const LFTextFormField(
      {super.key,
      this.validator,
      required this.label,
      this.keyboardType,
      this.maxLines = 1,
      this.onChanged,
      this.disable=false,
      this.initValue,
      this.obscureText = false,
      this.hintText = '',
      this.onSaved});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: obscureText,
        onSaved: onSaved,
        keyboardType: keyboardType,
        maxLines: maxLines,
        readOnly: disable,
        onChanged: onChanged,
        initialValue: initValue,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator:
            validator ?? (v) => v!.isEmpty ? 'Không được để trống' : null,
        decoration: InputDecoration(
          hintText: hintText,
          
          filled: true,
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),

            borderSide: BorderSide(width: 1, color: ColorManager.greyTF), //
          ),
          fillColor: ColorManager.greyTF,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(width: 1, color: ColorManager.greyTF), //
          ),
        ));
  }
}
