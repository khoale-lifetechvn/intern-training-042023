import 'package:flutter/material.dart';
import 'package:task_firebase/core/model/post_model.dart';
import 'package:task_firebase/core/service/get_navigation.dart';
import 'package:task_firebase/locator.dart';
import 'package:task_firebase/ui/presentation/main_view/main_manager_view/components/main_manager_tgg_button.dart';
import 'package:task_firebase/ui/resources/color_manager.dart';
import 'package:task_firebase/ui/resources/routes_manager.dart';
import 'package:task_firebase/ui/resources/styles_manager.dart';

class MainManagerList extends StatefulWidget {
  const MainManagerList({super.key, required this.list});
  final List<PostModel> list;

  @override
  State<MainManagerList> createState() => _MainManagerState();
}

class _MainManagerState extends State<MainManagerList> {
  late List<PostModel> list;
  @override
  void initState() {
    list = widget.list;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MainManagerList oldWidget) {
    list = widget.list;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MainManagerTggButton(onChangeIsDesc: (isDesc) {
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
        locator<GetNavigation>().to(RouterPath.mainDetail, arguments: model);
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: ColorManager.greyTF)),
      title: Text(
        model.title,
        style: getTitleText(),
      ),
      subtitle: Text(
        model.content,
        style: getLabelText(color: ColorManager.greyBG),
      ),
    );
  }
}
