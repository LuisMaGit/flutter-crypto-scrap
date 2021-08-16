import 'package:scrap/utils/enums.dart';

enum FilterHomeLeyend {
  Initial,
  Rating,
  Valor,
  Crypto,
  Payment,
}

class FilterHomeModel {
  final FilterHomeLeyend filter;
  final CryptoCode? selectedCrypto;
  final List<CryptoCode> cryptos;
  final String? selectedPayment;
  final List<String> payments;

  FilterHomeModel({
    this.filter = FilterHomeLeyend.Initial,
    this.selectedCrypto,
    this.selectedPayment,
    required this.cryptos,
    required this.payments,
  });


  @override
  String toString() {
    return 'FilterHomeModel(filter: $filter, selectedCrypto: $selectedCrypto, cryptos: $cryptos, selectedPayment: $selectedPayment, payments: $payments)';
  }

  FilterHomeModel copyWith({
    bool? isSellingFilter,
    FilterHomeLeyend? filter,
    CryptoCode? selectedCrypto,
    List<CryptoCode>? cryptos,
    String? selectedPayment,
    List<String>? payments,
  }) {
    return FilterHomeModel(
      filter: filter ?? this.filter,
      selectedCrypto: selectedCrypto ?? this.selectedCrypto,
      cryptos: cryptos ?? this.cryptos,
      selectedPayment: selectedPayment ?? this.selectedPayment,
      payments: payments ?? this.payments,
    );
  }
}
