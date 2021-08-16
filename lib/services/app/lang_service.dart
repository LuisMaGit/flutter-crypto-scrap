import 'dart:async';
import 'package:intl/intl.dart';
import 'package:scrap/locator/locator.dart';
import 'package:scrap/services/app/local_storage_service.dart';

class LangService {
  final _storageService = locator<LocalStorageService>();

  late StreamController<bool> langController;

  LangService() {
    langController = StreamController<bool>.broadcast();
  }
  //TODO: IN STARTUP MAKE A LOGIC THAT GET SAVED LANGUAGE SET IT

  String get selectedCodeCountryCodeLang => Intl.getCurrentLocale();

  void changeLang(String codeCountryCode) {
    if (selectedCodeCountryCodeLang == codeCountryCode) return;

    _storageService.set(KeyStorage.LanguageCodeAndContryCode, codeCountryCode);
    langController.add(true);
  }
}
