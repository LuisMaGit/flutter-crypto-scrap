import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrap/router/routes.dart';
import 'package:scrap/ui/views/home/filter_home/filter_home.dart';
import 'package:scrap/ui/views/home/home.dart';
import 'package:scrap/ui/views/home/home_vm.dart';
import 'package:scrap/ui/views/offers_user/offers_user.dart';
import 'package:scrap/ui/views/settings/settings.dart';
import 'package:scrap/ui/views/tracker/tracker.dart';

abstract class AppRouter {
  static Route<dynamic?> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.Home:
        return CupertinoPageRoute(builder: (_) => Home());

      case Routes.Tracker:
        return CupertinoPageRoute(builder: (_) => Tracker());

      case Routes.Settings:
        return CupertinoPageRoute(builder: (_) => Settings());

      case Routes.OffersUser:
        return CupertinoPageRoute(builder: (_) => OffersUser());

      case Routes.FilterHomeMobile:
        final model = settings.arguments as HomeVM;
        return CupertinoPageRoute(
            builder: (_) => FilterHomeMobile(model: model));

      default:
        return CupertinoPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
