import 'package:flutter/material.dart';
import 'package:scrap/router/routes.dart';

class NavigatorService {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  Future<dynamic> goTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  void goBack([dynamic arguments]) {
    return navigatorKey.currentState!.pop(arguments);
  }

  Future<dynamic> replaceToHome() {
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(Routes.Home, ModalRoute.withName(Routes.Home));
  }
}
