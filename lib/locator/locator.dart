import 'package:get_it/get_it.dart';
import 'package:scrap/services/app/dynamic_dialog_service.dart';
import 'package:scrap/services/app/lang_service.dart';
import 'package:scrap/services/app/local_storage_service.dart';
import 'package:scrap/services/app/navigator_service.dart';
import 'package:scrap/services/app/simulation_api.dart';
import 'package:scrap/services/app/theme_service.dart';
import 'package:scrap/services/data/crypto_data_service.dart';
import 'package:scrap/ui/views/home/home_vm.dart';
import 'package:scrap/ui/views/offers_user/offers_user_vm.dart';
import 'package:scrap/ui/views/settings/settings_vm.dart';
import 'package:scrap/ui/views/startup/startup_vm.dart';
import 'package:scrap/ui/views/theme_builder/app_builder_vm.dart';
import 'package:scrap/ui/views/tracker/tracker_vm.dart';
import 'package:scrap/utils/enums.dart';

final locator = GetIt.instance;

void configureDependencies(Env env) {
  locator
    //VMs
    ..registerFactory(() => AppBuilderVM())
    ..registerFactory(() => HomeVM())
    ..registerFactory(() => TrackerVM())
    ..registerFactory(() => SettingsVM())
    ..registerFactory(() => OffersUserVM())
    ..registerFactory(() => StartupVM())
    //Services
    ..registerLazySingleton(() => DynamicDialogService())
    ..registerLazySingleton(() => NavigatorService())
    ..registerLazySingleton(() => ThemeService())
    ..registerLazySingleton(() => LangService())
    ..registerFactory(() => LocalStorageService());

  if (env == Env.Dev) {
    configureDevDependencies();
  }
  if (env == Env.Prod) {
    configureProdDependencies();
  }
}

void configureDevDependencies() {
  locator
    ..registerFactory<ICryptoDataService>(() => FakeCryptoDataService())
    ..registerFactory(() => SimulationApi());
}

void configureProdDependencies() {
  locator..registerFactory<ICryptoDataService>(() => CryptoDataService());
}
