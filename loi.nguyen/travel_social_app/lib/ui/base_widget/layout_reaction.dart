import 'package:flutter/material.dart';
import 'package:travel_social_app/core/model/emoji_model.dart';
import 'package:travel_social_app/core/service/singleton.dart';
import 'package:travel_social_app/locator.dart';
import 'package:travel_social_app/ui/resources/styles_manager.dart';

///It's will return 2 type string: stringID and remove
class LayoutReaction extends StatefulWidget {
  const LayoutReaction({super.key, this.emojiId});
  final String? emojiId;
  @override
  State<LayoutReaction> createState() => _LayoutReactionState();
}

class _LayoutReactionState extends State<LayoutReaction> {
  late List<EmojiModel> currentList;
  @override
  void initState() {
    currentList = locator<Singleton>().listEmoji;
    emojiIdCurrent = widget.emojiId;
    super.initState();
  }

  String? emojiIdCurrent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Reaction',
            style: getTitle1Text(),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(currentList.length, (index) {
              return item(model: currentList[index]);
            }),
          ),
          const Expanded(
              child: Center(child: Text('Thank you for the reaction!'))),
          Row(
            children: [
              itemButton(
                  onPressed: () {
                    bool isChangeCompareDefault =
                        widget.emojiId != emojiIdCurrent;
                    emojiIdCurrent ??= 'remove';
                    isChangeCompareDefault
                        ? Navigator.pop(context, emojiIdCurrent)
                        : Navigator.pop(context);
                  },
                  color: Colors.green,
                  title: 'Submit'),
              const SizedBox(width: 16),
              itemButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.red,
                  title: 'Cancel')
            ],
          )
        ],
      ),
    );
  }

  Widget itemButton(
      {required Function() onPressed,
      required Color color,
      required String title}) {
    return Expanded(
      child: MaterialButton(
        onPressed: onPressed,
        color: color,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Text(title),
      ),
    );
  }

  Widget item({required EmojiModel model}) {
    bool isSelected = emojiIdCurrent == model.id;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        if (isSelected) {
          setState(() {
            emojiIdCurrent = null;
          });
        } else {
          setState(() {
            emojiIdCurrent = model.id;
          });
        }
      },
      child: Ink(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isSelected ? Colors.pink : null),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(model.img, width: 40, height: 40),
            const SizedBox(height: 8),
            Text(model.title)
          ],
        ),
      ),
    );
  }
}
