import 'package:scrap/locator/locator.dart';
import 'package:scrap/services/app/navigator_service.dart';
import 'package:scrap/ui/base_vm.dart';

class StartupVM extends BaseVM {
  final _navigationService = locator<NavigatorService>();

  Future<void> initStartup() async {

    await Future.delayed(Duration(seconds: 2));
    _navigationService.replaceToHome();
  }
}
