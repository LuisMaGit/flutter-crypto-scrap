import 'package:flutter/material.dart';
import 'package:scrap/ui/base_view.dart';
import 'package:scrap/ui/styles/kStyles.dart';
import 'package:scrap/ui/views/theme_builder/app_builder_vm.dart';
import 'package:scrap/utils/assets_helpers.dart';
import 'package:scrap/utils/enums.dart';

class AppBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ThemeData theme) builder;

  const AppBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _getTheme(ThemeModeApp mode) {
      late ColorScheme colorScheme;

      switch (mode) {
        case ThemeModeApp.Light:
          colorScheme = ColorScheme.light(
            primary: kOrange,
            primaryVariant: kBlue,
            onPrimary: kOrange.withOpacity(.5),
            background: kWhiteDarker,
            onBackground: kWhite,
            secondary: kBlack,
            onSecondary: kBlackDarker,
            secondaryVariant: kGrayDarker,
          );
          break;

        case ThemeModeApp.Dark:
          colorScheme = ColorScheme.dark(
            primary: kOrange,
            primaryVariant: kBlue,
            onPrimary: kOrange.withOpacity(.5),
            background: kBlackDarker,
            onBackground: kBlack,
            secondary: kWhiteDarker,
            onSecondary: kWhite,
            secondaryVariant: kGray,
          );
          break;
      }

      return ThemeData(
        primaryColor: colorScheme.primary,
        colorScheme: colorScheme,
        backgroundColor: colorScheme.background,
        canvasColor: colorScheme.background,
        scaffoldBackgroundColor: colorScheme.background,
        accentColor: colorScheme.primary,
        textTheme: TextTheme(
            headline1: TextStyle(
                color: colorScheme.secondary,
                fontSize: 24,
                fontFamily: Fonts.RubikSemiBold),
            headline2: TextStyle(
                color: colorScheme.secondary,
                fontSize: 20,
                fontFamily: Fonts.RubikMedium),
            bodyText1: TextStyle(
                color: colorScheme.secondary,
                fontSize: 16,
                fontFamily: Fonts.RubikRegular),
            bodyText2: TextStyle(
                color: colorScheme.secondary,
                fontSize: 14,
                fontFamily: Fonts.RubikRegular),
            caption: TextStyle(
                color: colorScheme.secondaryVariant,
                fontSize: 12,
                fontFamily: Fonts.RubikRegular)),
      );
    }

    return BaseView<AppBuilderVM>(
      initViewModel: (model) {
        model.initTheme();
      },
      builder: (context, model, _) {
        return builder(context, _getTheme(model.themeMode));
      },
    );
  }
}
