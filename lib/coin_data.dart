import 'package:flutter/material.dart';
import 'services/coin_model.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  CoinModel exchange = CoinModel();

  late double rate;
  late String currencyType;

  Future<void> getRateCurrency(value) async {
    try {
      var coinData = await exchange.getCoinData(currencyType, currencyType);
      rate = coinData['rate'];
    } catch (e) {
      print(e);
    }
  }
}
