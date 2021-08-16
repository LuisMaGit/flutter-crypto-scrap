import 'package:scrap/locator/locator.dart';
import 'package:scrap/services/app/lang_service.dart';
import 'package:scrap/services/app/theme_service.dart';
import 'package:scrap/ui/base_vm.dart';
import 'package:scrap/utils/enums.dart';

class AppBuilderVM extends BaseVM {
  final _themeService = locator<ThemeService>();
  final _langService = locator<LangService>();
  bool algo = false;
  late ThemeModeApp themeMode;

  void initTheme() {
    themeMode = _themeService.themeMode;

    final streamTheme = _themeService.themeController.stream;
    final streamLang = _langService.langController.stream;
    streamTheme.listen((value) {
      _swichTheme(value);
    });

    streamLang.listen((value) {
      notifyListeners();
    });
  }

  void _swichTheme(ThemeModeApp value) {
    themeMode = value;
    notifyListeners();
  }
}
