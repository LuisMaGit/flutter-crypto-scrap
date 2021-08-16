import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scrap/locator/locator.dart';
import 'package:scrap/router/app_router.dart';
import 'package:scrap/services/app/navigator_service.dart';
import 'package:scrap/ui/views/startup/startup.dart';
import 'package:scrap/ui/views/theme_builder/app_builder.dart';
import 'package:scrap/utils/enums.dart';
import 'generated/l10n.dart';

void main() {
  configureDependencies(Env.Prod);
  runApp(Scrap());
}

class Scrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBuilder(
      builder: (context, theme) => MaterialApp(
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          theme: theme,
          debugShowCheckedModeBanner: false,
          title: 'Crypto Scrap',
          navigatorKey: locator<NavigatorService>().navigatorKey,
          onGenerateRoute: AppRouter.onGenerateRoute,
          home: Startup()),
    );
  }
}
