import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_social_app/core/extension/extension.dart';
import 'package:travel_social_app/core/model/base_table.dart';
import 'package:travel_social_app/core/service/api_nosql.dart';
import 'package:travel_social_app/core/service/get_navigation.dart';
import 'package:travel_social_app/core/service/singleton.dart';
import 'package:travel_social_app/locator.dart';
import 'package:travel_social_app/core/extension/enum.dart';
import 'package:travel_social_app/ui/base_widget/lf_dialog.dart';
import 'package:travel_social_app/ui/resources/color_manager.dart';

class PostFollowItem extends StatefulWidget {
  const PostFollowItem(
      {super.key, required this.uid, this.isIconFavorite = false});
  final String uid;
  final bool isIconFavorite;

  @override
  State<PostFollowItem> createState() => _PostFollowItemState();
}

class _PostFollowItemState extends State<PostFollowItem> {
  bool isFollow = false;

  void updateFollow() {
    final ApiNosql apiNosql = ApiNosql(
        parentTable: BaseTable.following,
        parentID: widget.uid,
        childTable: BaseTable.userFollowing);
    apiNosql.addDocumentNN(id: locator<Singleton>().userModel.id).then((value) {
      if (value == Status.add.name) {
        locator<GetNavigation>().openDialog(
            content: 'Follow Successfully', typeDialog: TypeDialog.sucesss);
        setState(() {
          isFollow = true;
        });
      } else if (value == Status.remove.name) {
        locator<GetNavigation>().openDialog(
            content: 'Unfollow Successfully', typeDialog: TypeDialog.sucesss);
        setState(() {
          isFollow = false;
        });
      } else {
        locator<GetNavigation>().openDialog(content: value);
      }
    });
  }

  String get uid => widget.uid;

  late final ApiNosql _apiNosql = ApiNosql(
      parentTable: BaseTable.following,
      parentID: uid,
      childTable: BaseTable.userFollowing);

  Future<QuerySnapshot<Object?>?> loadData() {
    return _apiNosql.ref
        .where(FieldPath.documentId,
            isEqualTo: locator<Singleton>().userModel.id)
        .get();
  }

  bool isLoadFirst = true;

  @override
  Widget build(BuildContext context) {
    return isLoadFirst
        ? FutureBuilder(
            future: loadData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text('....');
              } else {
                isFollow = snapshot.data.toListMap().isNotEmpty;
                isLoadFirst = false;
                return icon();
              }
            })
        : icon();
  }

  Widget icon() {
    return IconButton(
        onPressed: updateFollow,
        icon: isFollow
            ? widget.isIconFavorite
                ? Icon(Icons.favorite, color: ColorManager.red)
                : const Icon(Icons.bookmark_sharp)
            : widget.isIconFavorite
                ? const Icon(Icons.favorite_border)
                : const Icon(Icons.bookmark_border));
  }
}
