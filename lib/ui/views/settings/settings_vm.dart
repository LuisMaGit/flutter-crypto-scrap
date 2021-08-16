import 'package:scrap/locator/locator.dart';
import 'package:scrap/services/app/lang_service.dart';
import 'package:scrap/services/app/navigator_service.dart';
import 'package:scrap/services/app/theme_service.dart';
import 'package:scrap/ui/base_vm.dart';
import 'package:scrap/utils/enums.dart';


class SettingsVM extends BaseVM {
  final _themeService = locator<ThemeService>();
  final _langService = locator<LangService>();
  final _navigator = locator<NavigatorService>();

  bool get isDarkMode => _themeService.themeMode == ThemeModeApp.Dark;
  String get selectedCodeCountryCodeLang => _langService.selectedCodeCountryCodeLang;

  void changeTheme() => _themeService.switchTheme();

  void changeLang(String codeCountryCode) {

    _navigator.goBack();
    _langService.changeLang(codeCountryCode);
  }
}
