import 'package:flutter/material.dart';
import 'package:travel_social_app/core/model/post_model.dart';
import 'package:travel_social_app/core/service/get_navigation.dart';
import 'package:travel_social_app/locator.dart';
import 'package:travel_social_app/ui/presentation/post_view/post_manager_view/components/post_manager_tgg_button.dart';
import 'package:travel_social_app/ui/resources/color_manager.dart';
import 'package:travel_social_app/ui/resources/routes_manager.dart';
import 'package:travel_social_app/ui/resources/styles_manager.dart';

class PostManagerList extends StatefulWidget {
  const PostManagerList({super.key, required this.list});
  final List<PostModel> list;

  @override
  State<PostManagerList> createState() => _MainManagerState();
}

class _MainManagerState extends State<PostManagerList> {
  late List<PostModel> list;
  @override
  void initState() {
    list = widget.list;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PostManagerList oldWidget) {
    list = widget.list;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PostManagerTggButton(onChangeIsDesc: (isDesc) {
          setState(() {
            if (isDesc) {
              list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
            } else {
              list.sort((a, b) => a.createdAt.compareTo(b.createdAt));
            }
          });
        }),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            itemCount: list.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (_, i) => cardPost(
              list[i],
            ),
          ),
        ),
      ],
    );
  }

  Widget cardPost(PostModel model) {
    return ListTile(
      onTap: () {
        locator<GetNavigation>().to(RouterPath.postDetail, arguments: model);
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: ColorManager.greyTF)),
      title: Text(
        model.title,
        style: getTitle1Text(),
      ),
      subtitle: Text(
        model.content,
        style: getLabelText(color: ColorManager.greyBG),
      ),
    );
  }
}
