import 'package:flutter/material.dart';
import 'package:task_firebase/core/model/post_model.dart';
import 'package:task_firebase/core/model/user_model.dart';
import 'package:task_firebase/ui/presentation/block_user_view/block_user_view.dart';
import 'package:task_firebase/ui/presentation/detail_author_view/detail_author_view.dart';
import 'package:task_firebase/ui/presentation/follow_users_view/follow_users_view.dart';
import 'package:task_firebase/ui/presentation/home_view/home_view.dart';
import 'package:task_firebase/ui/presentation/login_view/login_view.dart';
import 'package:task_firebase/ui/presentation/post_view/post_add_view/post_add_view.dart';
import 'package:task_firebase/ui/presentation/post_view/post_detail_view/post_detail_view.dart';
import 'package:task_firebase/ui/presentation/post_view/post_manager_view/post_manger_view.dart';
import 'package:task_firebase/ui/presentation/register_view/register_view.dart';
import 'package:task_firebase/ui/presentation/user_view/user_detail_view/user_detail_view.dart';
import 'package:task_firebase/ui/presentation/user_view/user_view.dart';

class RouterPath {
  static const String postAdd = "/postAdd";
  static const String postDetail = "/postDetail";
  static const String postManager = "/postManager";

  static const String login = "/";
  static const String register = "/register";
  static const String user = "/user";
  static const String userDetail = "/userDetail";

  static const String followUsers = "/followUsers";
  static const String detailAuthor = "/detailAuthor";

  static const String blockUsers = "/blockUsers";

  static const String home = "/home";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      //Account
      case RouterPath.login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case RouterPath.register:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case RouterPath.user:
        return MaterialPageRoute(builder: (_) => const UserView());
      case RouterPath.userDetail:
        return MaterialPageRoute(builder: (_) => UserDetailView());

      //Home
      case RouterPath.home:
        return MaterialPageRoute(builder: (_) => const HomeView());

      //FindUser and follow
      case RouterPath.followUsers:
        return MaterialPageRoute(builder: (_) => FollowUsersView());
      case RouterPath.detailAuthor:
        UserModel user = routeSettings.arguments as UserModel;
        return MaterialPageRoute(builder: (_) => DetailAuthorView(user: user));

      //Blocks
      case RouterPath.blockUsers:
        return MaterialPageRoute(builder: (_) => BlockUserView());

      //Posts
      case RouterPath.postAdd:
        return MaterialPageRoute(builder: (_) => PostAddView());
      case RouterPath.postManager:
        return MaterialPageRoute(builder: (_) => const PostManagerView());
      case RouterPath.postDetail:
        PostModel post = routeSettings.arguments as PostModel;
        return MaterialPageRoute(
            builder: (_) => PostDetailView(
                  model: post,
                ));

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('No router'),
              ),
              body: const Center(
                child: Text('No router found'),
              ),
            ));
  }
}
