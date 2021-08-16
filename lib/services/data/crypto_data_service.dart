import 'package:http/http.dart';
import 'package:scrap/models/data/crypto_model.dart';
import 'package:scrap/utils/api_helpers.dart';

abstract class ICryptoDataService {
  Map<String, List<CryptoModel>> data = {};

  Future<bool> getData(
      String firstDate, String lastDate, String cryptos, String fiat);
}

class FakeCryptoDataService extends ICryptoDataService {
  @override
  Future<bool> getData(
      String firstDate, String lastDate, String cryptos, String fiat) async {
    await Future.delayed(Duration(seconds: 1));

    final _cryptosList = cryptos.split(',');

    for (String crypto in _cryptosList) {
      data.addAll({
        crypto: [
          CryptoModel(time: '1', price: 5000),
          CryptoModel(time: '1', price: 5010),
          CryptoModel(time: '1', price: 5020),
          CryptoModel(time: '1', price: 4920),
          CryptoModel(time: '1', price: 5050),
          CryptoModel(time: '1', price: 5030),
          CryptoModel(time: '1', price: 5053),
          CryptoModel(time: '1', price: 5200),
          CryptoModel(time: '1', price: 5023),
          CryptoModel(time: '1', price: 4980),
          CryptoModel(time: '1', price: 4820),
          CryptoModel(time: '1', price: 5130),
          CryptoModel(time: '1', price: 4840),
          CryptoModel(time: '1', price: 5100),
          CryptoModel(time: '1', price: 5200),
          CryptoModel(time: '1', price: 5000),
          CryptoModel(time: '1', price: 5010),
          CryptoModel(time: '1', price: 5020),
        ]
      });
    }

    return true;
  }
}

class CryptoDataService extends ICryptoDataService {
  set _setCryptoResponseData(String source) {
    final response = CryptoResponseModel.fromJson(source);
    data = response.cryptoData;
  }

  @override
  Future<bool> getData(
    String firstDate,
    String lastDate,
    String cryptos,
    String fiat,
  ) async {
    final queryParameters = {
      'key': NmonicsApi.nmonicsKey,
      'ids': cryptos,
      'start': firstDate,
      'end': lastDate,
      'convert': fiat,
    };

    final uri = Uri.https(NmonicsApi.url, NmonicsApi.endpoint, queryParameters);
    try {
      final response = await get(uri, headers: {
        'Access-Control-Request-Method': 'GET',
        'Access-Control-Request-Headers': '*',
        'Origin': 'https://luismagit.github.io'
      });
      if (response.statusCode == ApiResponse.Ok) {
        _setCryptoResponseData = response.body;
        return true;
      }
      return false;
    } on Exception {
      return false;
    }
  }
}
