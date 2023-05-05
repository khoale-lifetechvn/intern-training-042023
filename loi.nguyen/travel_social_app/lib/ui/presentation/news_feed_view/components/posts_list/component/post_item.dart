import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_social_app/core/model/base_table.dart';
import 'package:travel_social_app/core/model/port_user_model.dart';
import 'package:travel_social_app/core/model/post_model.dart';
import 'package:travel_social_app/core/service/api_nosql.dart';
import 'package:travel_social_app/core/service/get_navigation.dart';
import 'package:travel_social_app/core/service/singleton.dart';
import 'package:travel_social_app/locator.dart';
import 'package:travel_social_app/ui/base_widget/lf_dialog.dart';
import 'package:travel_social_app/ui/presentation/news_feed_view/components/posts_list/component/post_comment_item/post_comment_item.dart';
import 'package:travel_social_app/ui/presentation/news_feed_view/components/posts_list/component/post_emoji_item/controller/post_emoji_item_controller.dart';
import 'package:travel_social_app/ui/presentation/news_feed_view/components/posts_list/component/post_emoji_item/post_emoji_item.dart';
import 'package:travel_social_app/ui/presentation/news_feed_view/components/posts_list/component/post_follow_item.dart';
import 'package:travel_social_app/ui/resources/routes_manager.dart';
import 'package:travel_social_app/ui/resources/styles_manager.dart';

class PostItem extends StatelessWidget {
  PostItem({super.key, required this.postUser, this.isFollow = true});

  final PostUserModel postUser;

  final bool isFollow;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostEmojiItemController(postID: postUser.post.id),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Info User
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    child: Image.network(postUser.user.showImg),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        postUser.user.showName,
                        style: getTitle3Text(),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        postUser.post.updateDateRelative,
                        style: getSmallText(),
                      )
                    ],
                  )
                ],
              ),
              iconPopup(postUser.post),
            ],
          ),
          const SizedBox(height: 8),
          //Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              postUser.post.showImg,
              height: 250,
              fit: BoxFit.fitWidth,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 8),
          //Row icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  PostEmojiItem(postID: postUser.post.id),
                  const SizedBox(width: 8),
                  PostsCommentItem(postId: postUser.post.id)
                ],
              ),
              isFollow
                  ? PostFollowItem(uid: postUser.user.id)
                  : const SizedBox.shrink()
            ],
          ), //
          //  Content
          Text(
            postUser.post.title,
            style: getLabelText(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  Widget iconPopup(PostModel post) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          // row with 2 children
          child: Row(
            children: const [
              Icon(Icons.remove),
              SizedBox(
                width: 10,
              ),
              Text("Remove")
            ],
          ),
        ),
        // PopupMenuItem 2
        PopupMenuItem(
          value: 2,
          // row with two children
          child: Row(
            children: const [
              Icon(Icons.edit),
              SizedBox(
                width: 10,
              ),
              Text("Edit")
            ],
          ),
        ),
      ],

      elevation: 2,
      // on selected we show the dialog box
      onSelected: (value) {
        if (post.refID != locator<Singleton>().userModel.id) {
          locator<GetNavigation>().openDialog(
              typeDialog: TypeDialog.waring,
              content: 'You do not have permission to edit this post');
        } else {
          if (value == 1) {
            deletePost(postId: post.id);
          } else if (value == 2) {
            locator<GetNavigation>()
                .to(RouterPath.managerPost, arguments: post);
          }
        }
      },
    );
  }

  void deletePost({required String postId}) async {
    await _api.removeData(postId).then((value) {
      if (value != null) {
        locator<GetNavigation>().openDialog(content: value);
      } else {
        locator<GetNavigation>().openDialog(
            content: 'Remove post successfully',
            typeDialog: TypeDialog.sucesss);
      }
    });
  }

  final ApiNosql _api = ApiNosql(
    parentTable: BaseTable.posts,
    parentID: locator<Singleton>().userModel.id,
    childTable: BaseTable.userPosts,
  );
}
