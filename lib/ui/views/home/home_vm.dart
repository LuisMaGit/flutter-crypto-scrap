import 'package:scrap/locator/locator.dart';
import 'package:scrap/models/app/filter_home_data_model.dart';
import 'package:scrap/router/routes.dart';
import 'package:scrap/services/app/navigator_service.dart';
import 'package:scrap/services/app/theme_service.dart';
import 'package:scrap/ui/base_vm.dart';
import 'package:scrap/utils/enums.dart';

typedef StartAnimation = Future<void> Function();

class HomeVM extends BaseVM {
  final _navigatorService = locator<NavigatorService>();
  final _themeService = locator<ThemeService>();

  late StartAnimation _startAnimation;
  //STATES
  bool selling = true;
  ThemeModeApp get theme => _themeService.themeMode;
  late FilterHomeModel _filter;
  FilterHomeModel get filter => _filter;
  bool get hasFilter => _filter.filter != FilterHomeLeyend.Initial;

  //EVENTS
  void initHomeVM({required StartAnimation startAnimation}) {
    _startAnimation = startAnimation;
    _filter = FilterHomeModel(
      cryptos: CryptoCode.values.map((c) => c).toList(),
      filter: FilterHomeLeyend.Initial,
      payments: [
        'Payment',
        'Payment',
        'Payment',
        'Payment',
      ],
    );
  }

  Future<void> changeScreen(bool value) async {
    if (value == selling) return;

    await _startAnimation();
    selling = !selling;
    notifyListeners();
  }

  void goToTracker() => _navigatorService.goTo(Routes.Tracker);
  void goToSettngs() => _navigatorService.goTo(Routes.Settings);
  void goToUserOffers(int idx) {
    _navigatorService.goTo(Routes.OffersUser);
  }

  void _submitFilter(FilterHomeModel filter) {
    _filter = filter;
    notifyListeners();
  }

  void submitFilterFromMobile(FilterHomeModel filter) {
    _navigatorService.goBack();
    _submitFilter(filter);
  }

  void submitDialogFilterFromMobile(FilterHomeModel filter) {
    _navigatorService.goBack();
    _navigatorService.goBack();
    _submitFilter(filter);
  }

  void submitFilterFromDesktop(FilterHomeModel filter) {
    _submitFilter(filter);
  }

  void submitDialogFilterFromDesktop(FilterHomeModel filter) {
    _navigatorService.goBack();
    _submitFilter(filter);
  }

  void closeFilterFromMobile() {
    _navigatorService.goBack();
    _submitFilter(_filter.copyWith(filter: FilterHomeLeyend.Initial));
  }

  void closeFilterFromDesktop() {
    _submitFilter(_filter.copyWith(filter: FilterHomeLeyend.Initial));
  }
}
