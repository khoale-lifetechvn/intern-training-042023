import 'package:flutter/material.dart';
import 'package:task_firebase/core/model/post_model.dart';
import 'package:task_firebase/ui/presentation/login_view/login_view.dart';
import 'package:task_firebase/ui/presentation/main_view/main_add_view/main_add_view.dart';
import 'package:task_firebase/ui/presentation/main_view/main_detail_view/main_detail_view.dart';
import 'package:task_firebase/ui/presentation/main_view/main_manager_view/main_manger_view.dart';
import 'package:task_firebase/ui/presentation/register_view/register_view.dart';
import 'package:task_firebase/ui/presentation/user_view/user_detail_view/user_detail_view.dart';
import 'package:task_firebase/ui/presentation/user_view/user_view.dart';

class RouterPath {
  static const String mainAdd = "/mainAdd";
  static const String mainDetail = "/mainDetail";
  static const String mainManager = "/mainManager";

  static const String login = "/";
  static const String register = "/register";
  static const String user = "/user";
  static const String userDetail = "/userDetail";
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

      //Quizz
      case RouterPath.mainAdd:
        return MaterialPageRoute(builder: (_) => MainAddView());
      case RouterPath.mainManager:
        return MaterialPageRoute(builder: (_) => const MainManagerView());
      case RouterPath.mainDetail:
        PostModel post = routeSettings.arguments as PostModel;
        return MaterialPageRoute(
            builder: (_) => MainDetailView(
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
