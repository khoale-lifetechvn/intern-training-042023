import 'package:flutter/material.dart';
import 'package:travel_social_app/core/extension/log.dart';
import 'package:travel_social_app/core/service/auth_service.dart';
import 'package:travel_social_app/core/service/singleton.dart';
import 'package:travel_social_app/locator.dart';
import 'package:travel_social_app/ui/base_widget/layout_reaction.dart';
import 'package:travel_social_app/ui/base_widget/lf_dialog.dart';
import 'package:travel_social_app/ui/resources/routes_manager.dart';

class GetNavigation {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Future<dynamic> to(String routeName, {Object? arguments}) async {
    return navigatorKey.currentState
        ?.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> replaceTo(String routeName, {Object? arguments}) async {
    return await navigatorKey.currentState
        ?.pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> toAndRemoveUntil(String routeName,
      {Object? arguments}) async {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
        routeName, (router) => false,
        arguments: arguments);
  }

  Future<dynamic> back() async {
    return navigatorKey.currentState?.pop();
  }

  Future<dynamic> toLogout() async {
    AuthenticationService service = AuthenticationService();
    locator<Singleton>().userModel.data.clear();
    await service.signOut().whenComplete(() {
      logSuccess('Logout success');
    });
    return navigatorKey.currentState
        ?.pushNamedAndRemoveUntil(RouterPath.login, (router) => false);
  }

  Future<void> openDialog(
      {String? title,
      TypeDialog typeDialog = TypeDialog.error,
      String? content,
      Function()? onClose,
      Function()? onSubmit}) async {
    await showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) {
        return BaseADialog(
          content: content,
          onClose: onClose,
          onSubmit: onSubmit,
          title: title,
          typeDialog: typeDialog,
        );
      },
    );
  }

  void openReaction(
      {required Function(String emojiID) onChangeSubmit,
      String? emojiId}) async {
    String? result = await showModalBottomSheet(
        context: navigatorKey.currentContext!,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        )),
        builder: (_) {
          return LayoutReaction(
            emojiId: emojiId,
          );
        });
    if (result != null) {
      onChangeSubmit(result);
    }
  }
}
