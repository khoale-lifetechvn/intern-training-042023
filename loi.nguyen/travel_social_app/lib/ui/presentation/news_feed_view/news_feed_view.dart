import 'package:flutter/material.dart';
import 'package:travel_social_app/ui/presentation/home_view/base_home_view.dart';
import 'package:travel_social_app/ui/presentation/news_feed_view/components/posts_list/posts_list.dart';
import 'package:travel_social_app/ui/presentation/news_feed_view/components/story_item/story_item.dart';
import 'package:travel_social_app/ui/resources/styles_manager.dart';

class NewsFeedView extends BaseHomeView {
  const NewsFeedView({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        baseContent(
          content: 'May you know?',
          widget: const StoryItem(),
        ),
        const SizedBox(height: 24),
        baseContent(content: 'Popular', widget: PostsList())
      ],
    );
  }

  Widget baseContent({required String content, required Widget widget}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(content, style: getTitle2Text()),
        const SizedBox(height: 16),
        widget
      ],
    );
  }
}
