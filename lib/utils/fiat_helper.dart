import 'package:scrap/utils/enums.dart';

class FiatHelperModel {
  final String symbol;
  final String name;

  const FiatHelperModel({required this.symbol, required this.name});
}

const Map<FiatCode, FiatHelperModel> fiatDataHelper = {
  FiatCode.USD: const FiatHelperModel(
    symbol: '\$',
    name: 'USD',
  ),
  FiatCode.EUR: const FiatHelperModel(
    symbol: '€',
    name: 'EUR',
  ),
  FiatCode.CUP: const FiatHelperModel(
    symbol: 'CUP',
    name: 'CUP',
  ),
};
