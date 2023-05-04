import 'package:flutter/material.dart';
import 'package:travel_social_app/core/extension/debounce.dart';
import 'package:travel_social_app/ui/resources/color_manager.dart';

class SearchItem extends StatefulWidget {
  const SearchItem(
      {super.key,
      required this.onChanged,
      this.secondDuration = 1,
      this.hint = 'Search data'});
  final void Function(String) onChanged;
  final int secondDuration;
  final String hint;

  @override
  State<SearchItem> createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  final TextEditingController _textEditingController = TextEditingController();

  final Debounce _debounce = Debounce(const Duration(milliseconds: 600));

  bool showIconClear = false;

  @override
  void initState() {
    _textEditingController.addListener(() {
      if (_textEditingController.text.isEmpty) {
        setState(() {
          showIconClear = false;
        });
      } else {
        setState(() {
          showIconClear = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _debounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextField(
        onChanged: (_) {
          _debounce(() {
            widget.onChanged(_textEditingController.text);
          });
        },
        onSubmitted: (_) {
          widget.onChanged(_textEditingController.text);
        },
        controller: _textEditingController,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: widget.hint,
          prefixIcon: const Icon(Icons.search),
          fillColor: ColorManager.greyTF,
          filled: true,
          isDense: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25.0),
            ),
          ),
          suffixIcon: showIconClear
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _textEditingController.clear();
                    widget.onChanged(_textEditingController.text);
                  },
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
