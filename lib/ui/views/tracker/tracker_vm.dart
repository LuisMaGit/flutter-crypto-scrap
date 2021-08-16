import 'package:scrap/locator/locator.dart';
import 'package:scrap/models/data/crypto_model.dart';
import 'package:scrap/services/app/dynamic_dialog_service.dart';
import 'package:scrap/services/app/navigator_service.dart';
import 'package:scrap/services/data/crypto_data_service.dart';
import 'package:scrap/ui/base_vm.dart';
import 'package:scrap/utils/enums.dart';

part 'tracker_model.dart';

class TrackerVM extends BaseVM {
  final _cryptoDataService = locator<ICryptoDataService>();
  final _dialogService = locator<DynamicDialogService>();
  final _navigatorService = locator<NavigatorService>();

  bool showLine = false;

  CryptoDetailsModel get detailsSelected =>
      _fullCryptoDataModel[cryptoSelected]![timeSpanSelected]![fiatSelected]!;

  CryptoDetailsModel detailsOf(CryptoCode cryptoCode) =>
      _fullCryptoDataModel[_cryptoCodeToTrackFromCryptoCode(cryptoCode)]![
          timeSpanSelected]![fiatSelected]!;

  String get strCryptoCodeSelected => strCodeOf(cryptoSelected);
  String get strFiatCodeSelected => fiatSelected.toString().split('.')[1];
  String strCodeOf(CryptoCode cryptoCode) {
    return cryptoCode.toString().split('.')[1];
  }

  CryptoCode _cryptoCodeFromCryptoCodeStr(String str) {
    for (int x = 0; x < listCryptosToTrack.length; x++) {
      if (strCodeOf(listCryptosToTrack[x]) == str) {
        return listCryptosToTrack[x];
      }
    }

    return CryptoCode.UNKNOW;
  }

  CryptoCode _cryptoCodeToTrackFromCryptoCode(CryptoCode cryptoCode) {
    return listCryptosToTrack.firstWhere((c) => c == cryptoCode);
  }

  CryptoCode cryptoSelected = listCryptosToTrack.first;
  TimeSpan timeSpanSelected = TimeSpan.Day;
  FiatCode fiatSelected = FiatCode.USD;

  late Map<CryptoCode, Map<TimeSpan, Map<FiatCode, CryptoDetailsModel>>>
      _fullCryptoDataModel;
  late Map<TimeSpan, DateModel> _datesByTimeSpan;
  String _listCryptosToTrackStr = '';

  late AnimationCallback _startAnimation;
  late AnimationCallback _reverseAnimation;
  late ShowFiatDialogCallback _showFiatDialog;

  void _initDatesByTimeSpan() {
    _datesByTimeSpan = {};
    final nowDateTime = DateTime.now();
    final now = nowDateTime.toUtc().toIso8601String();

    String substractDateFromNow(Duration duration) =>
        nowDateTime.subtract(duration).toUtc().toIso8601String();

    void addDate(TimeSpan date, int days) {
      _datesByTimeSpan.addAll(
          {date: DateModel(substractDateFromNow(Duration(days: days)), now)});
    }

    TimeSpan.values.forEach((date) {
      switch (date) {
        case TimeSpan.Day:
          addDate(date, 1);
          break;
        case TimeSpan.Week:
          addDate(date, 7);
          break;
        case TimeSpan.TwoWeeks:
          addDate(date, 14);
          break;
        case TimeSpan.Month:
          addDate(date, 30);
          break;
        case TimeSpan.Year:
          addDate(date, 365);
          break;
        case TimeSpan.TwoYears:
          addDate(date, 730);
          break;
        case TimeSpan.FiveYears:
          addDate(date, 1825);
          break;
        default:
      }
    });
  }

  void _initFullCryptoDataModel() {
    _fullCryptoDataModel = {};
    for (final code in listCryptosToTrack) {
      Map<TimeSpan, Map<FiatCode, CryptoDetailsModel>> timeMap = {};
      for (var time in TimeSpan.values) {
        Map<FiatCode, CryptoDetailsModel> fiatMap = {};
        for (var fiat in FiatCode.values) {
          fiatMap.addAll({fiat: CryptoDetailsModel(cryptoData: [])});
        }
        timeMap.addAll({time: fiatMap});
      }
      _fullCryptoDataModel.addAll({code: timeMap});
    }
  }

  void _initListCryptosToTrackStr() {
    listCryptosToTrack.forEach((c) {
      _listCryptosToTrackStr +=
          strCodeOf(c) + (listCryptosToTrack.last != c ? ',' : '');
    });
  }

  Future<void> _fetchData() async {
    final notError = await _cryptoDataService.getData(
      _datesByTimeSpan[timeSpanSelected]!.firstDate,
      _datesByTimeSpan[timeSpanSelected]!.secondDate,
      _listCryptosToTrackStr,
      strFiatCodeSelected,
    );

    if (notError) {
      setDataCryptoCryptos();
      setState = ViewState.Iddle;
      _startAnimation();
      return;
    }

    final dialogResponse =
        await _dialogService.showDialog(DynamicDialogType.SimpleError) as bool?;
    if (dialogResponse == null || !dialogResponse) {
      _navigatorService.goBack();
      return;
    }
    _fetchData();
  }

  Future<void> _handleChange() async {
    if (_fullCryptoDataModel[cryptoSelected]![timeSpanSelected]![fiatSelected]!
        .cryptoData
        .isEmpty) {
      setState = ViewState.Bussy;
      List<Future<void>> futures = [
        _reverseAnimation(),
        _fetchData(),
      ];
      await Future.wait(futures);
      return;
    }

    await _reverseAnimation();
    _startAnimation();
    setState = ViewState.Iddle;
  }

  Future<void> initTrackerVM({
    required AnimationCallback startAnimation,
    required AnimationCallback reverseAnimation,
    required ShowFiatDialogCallback showFiatDialog,
  }) async {
    _startAnimation = startAnimation;
    _reverseAnimation = reverseAnimation;
    _showFiatDialog = showFiatDialog;

    _initDatesByTimeSpan();
    _initListCryptosToTrackStr();
    _initFullCryptoDataModel();

    await _fetchData();
  }

  void setDataCryptoCryptos() {
    _cryptoDataService.data.forEach((key, value) {
      final cryptoCode = _cryptoCodeFromCryptoCodeStr(key);
      final last = value.last.price;
      final lastStr = last.toStringAsFixed(3);
      final first = value.first.price;
      final percentage = (last / first) * (first > last ? -1 : 1);
      final percentageStr = percentage.toStringAsFixed(3);
      _fullCryptoDataModel[cryptoCode]![timeSpanSelected]![fiatSelected]!
        ..last = last
        ..lastStr = lastStr
        ..percentage = percentage
        ..percentageStr = percentageStr
        ..cryptoData.addAll(value);
    });
  }

  Future<void> changeDate(TimeSpan t) async {
    if (t == timeSpanSelected) return;

    timeSpanSelected = t;

    await _handleChange();
  }

  Future<void> changeCrypto(CryptoCode c) async {
    if (c == cryptoSelected) return;

    cryptoSelected = c;

    await _handleChange();
  }

  Future<void> openFiatDialog() async {
    final fiat = await _showFiatDialog(fiatSelected);

    if (fiat == null || fiat == fiatSelected) return;

    fiatSelected = fiat;
    await _handleChange();
  }

  void handleShowLine(bool value) {
    if (value == showLine) return;

    showLine = value;
    notifyListeners();
  }
}
