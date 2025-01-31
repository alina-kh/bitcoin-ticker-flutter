import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const apiKey = 'F469257C-344A-4EDE-988A-E292ACD6DF26';
const openCoinURL = 'https://rest.coinapi.io/v1/exchangerate';

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
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> prices = {};
    for (String crypto in cryptoList) {
      String requestURL = '$openCoinURL/$crypto/$selectedCurrency?apikey=$apiKey';
      http.Response response = await http.get(Uri.parse(requestURL));
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double price = decodedData['rate'];
        prices[crypto] = price.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return prices;
  }
}
