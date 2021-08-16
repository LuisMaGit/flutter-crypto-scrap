import 'package:shared_preferences/shared_preferences.dart';

enum KeyStorage {
  ThemeMode,
  LanguageCodeAndContryCode,
}

class LocalStorageService {
  static const _base = 'crypto_scrapper';
  late Map<KeyStorage, String> _mapStorage;

  LocalStorageService() {
    _mapStorage = {};
    KeyStorage.values.forEach((key) {
      _mapStorage.addAll({key: '$_base${key.toString()}'});
    });
  }

  Future<void> set(KeyStorage keyStorage, String value) async {
    final _storage = await SharedPreferences.getInstance();
    await _storage.setString(_mapStorage[keyStorage] ?? '', value);
  }

  Future<String?> get(KeyStorage keyStorage) async {
    final _storage = await SharedPreferences.getInstance();
    return _storage.getString(_mapStorage[keyStorage] ?? '');
  }

  Future<void> delete(KeyStorage keyStorage) async {
    final _storage = await SharedPreferences.getInstance();
    await _storage.remove(_mapStorage[keyStorage] ?? '');
  }
}
