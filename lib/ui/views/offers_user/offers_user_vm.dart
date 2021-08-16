import 'package:scrap/locator/locator.dart';
import 'package:scrap/services/app/theme_service.dart';
import 'package:scrap/ui/base_vm.dart';
import 'package:scrap/utils/enums.dart';

typedef StartAnimation = Future<void> Function();

class OffersUserVM extends BaseVM {
  final _themeService = locator<ThemeService>();

  late StartAnimation _startAnimation;

  //STATES
  bool isSalesOffers = true;
  ThemeModeApp get theme => _themeService.themeMode;

  //EVENTS  
  void initOffersUserVM({required StartAnimation startAnimation}) {
    _startAnimation = startAnimation;
  }

  Future<void> changeScreen(bool value) async {
    if (value == isSalesOffers) return;

    await _startAnimation();
    isSalesOffers = !isSalesOffers;
    notifyListeners();
  }
}
