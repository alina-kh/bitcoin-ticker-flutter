import 'package:bitcoin_ticker/services/networking.dart';

const apiKey = 'F469257C-344A-4EDE-988A-E292ACD6DF26';
const openCoinURL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinModel {

  Future<dynamic> getCoinData(String currencyIn, String currencyOut) async {
    var url = '$openCoinURL/$currencyIn/$currencyOut?apiKey=$apiKey';

    NetworkHelper networkHelper = NetworkHelper(url);
    var coinData = await networkHelper.getData();
    print(coinData);

    return coinData;
  }
}
