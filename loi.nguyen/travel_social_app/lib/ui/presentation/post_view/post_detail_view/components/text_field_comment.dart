import 'package:flutter/material.dart';
import 'package:travel_social_app/core/service/get_navigation.dart';
import 'package:travel_social_app/locator.dart';
import 'package:travel_social_app/ui/resources/color_manager.dart';

class TextFieldComment extends StatefulWidget {
  const TextFieldComment({super.key, required this.onSubmit});
  final Function(String) onSubmit;

  @override
  State<TextFieldComment> createState() => _TextFieldCommentState();
}

class _TextFieldCommentState extends State<TextFieldComment> {
  final TextEditingController _commentController = TextEditingController();
  bool isEmpty = true;
  @override
  void initState() {
    _commentController.addListener(() {
      if (_commentController.text.isEmpty) {
        setState(() {
          isEmpty = true;
        });
      } else {
        setState(() {
          isEmpty = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submitComment() {
    if (_commentController.text.isEmpty) {
      locator<GetNavigation>().openDialog(content: 'Comment is empty');
    } else {
      widget.onSubmit(_commentController.text);
      _commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _commentController,
      decoration: InputDecoration(
        fillColor: ColorManager.greyTF,
        focusColor: ColorManager.greyTF,
        hintText: 'Add a comment...',
        suffixIcon: isEmpty
            ? const Icon(Icons.send)
            : IconButton(
                onPressed: _submitComment,
                icon: const Icon(Icons.send),
                color: ColorManager.blue,
              ),
        suffixIconColor: ColorManager.greyTF,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: ColorManager.greyBG)),
      ),
      maxLines: 1,
      textInputAction: TextInputAction.done,
    );
  }
}
