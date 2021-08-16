part of 'tracker_vm.dart';

//TYPES
typedef AnimationCallback = Future<void> Function();
typedef ScrollMoveCallback = void Function(int idxListCryptoToTrack);
typedef ShowFiatDialogCallback = Future<FiatCode?> Function(FiatCode c);

//TIME
enum TimeSpan {
  Day,
  Week,
  TwoWeeks,
  Month,
  Year,
  TwoYears,
  FiveYears,
}

//CRYPTOS TRACKED
const List<CryptoCode> listCryptosToTrack = [
  CryptoCode.BTC,
  CryptoCode.ETH,
  CryptoCode.DOGE,
  CryptoCode.LTC,
  CryptoCode.USDT,
  CryptoCode.TRX,
  CryptoCode.DAI,
  CryptoCode.XRP,
  CryptoCode.XMR,
  CryptoCode.DASH,
  CryptoCode.ADA,
];

//MODELS
class CryptoDetailsModel {
  List<CryptoModel> cryptoData;
  double percentage;
  String percentageStr;
  double last;
  String lastStr;

  CryptoDetailsModel({
    required this.cryptoData,
    this.percentage = 0.0,
    this.percentageStr = '',
    this.last = 0.0,
    this.lastStr = '',
  });
}

class DateModel {
  final String firstDate;
  final String secondDate;

  const DateModel(this.firstDate, this.secondDate);
}
