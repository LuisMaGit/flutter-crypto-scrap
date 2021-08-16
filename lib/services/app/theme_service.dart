import 'dart:async';
import 'package:scrap/locator/locator.dart';
import 'package:scrap/services/app/local_storage_service.dart';
import 'package:scrap/utils/enums.dart';

class ThemeService {
  final _storageService = locator<LocalStorageService>();

  late StreamController<ThemeModeApp> themeController;
  ThemeModeApp _themeMode = ThemeModeApp.Dark;
  ThemeModeApp get themeMode => _themeMode;

  ThemeService() {
    themeController = StreamController<ThemeModeApp>.broadcast();
  }

  Future<void> switchTheme() async {
    _themeMode = _themeMode == ThemeModeApp.Light
        ? ThemeModeApp.Dark
        : ThemeModeApp.Light;
    await _storageService.set(
        KeyStorage.ThemeMode, _themeMode.index.toString());
    themeController.add(_themeMode);
  }

  Future<void> setStoredThemeMode() async {
    final themeStr = await _storageService.get(KeyStorage.ThemeMode);

    if (themeStr == null) {
      return;
    }

    int idx = int.parse(themeStr);

    _themeMode = ThemeModeApp.values[idx];
    themeController.add(_themeMode);
  }

  Future<void> dispose() async {
    await _storageService.delete(KeyStorage.ThemeMode);
  }
}
