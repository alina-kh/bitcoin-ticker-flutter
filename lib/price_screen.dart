import 'dart:io' show Platform;
import 'package:bitcoin_ticker/services/coin_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  PriceScreen({this.exchangeCoin});

  final exchangeCoin;

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinModel exchange = CoinModel();

  late double rate;

  String selectedCurrencyIn = 'BTC';
  String selectedCurrencyOut = 'USD';

  // DropdownButton<String> getDropdownButton() {
  //   List<DropdownMenuItem<String>> dropdownItems = [];
  //
  //   for (String currency in currenciesList) {
  //     var newItem = DropdownMenuItem(
  //       child: Text(currency),
  //       value: currency,
  //     );
  //     dropdownItems.add(newItem);
  //   }
  //
  //   return DropdownButton<String>(
  //     value: selectedCurrency,
  //     items: dropdownItems,
  //     onChanged: (value) {
  //       setState(() {
  //         selectedCurrency = value!;
  //       });
  //     },
  //   );
  // }
  //
  // CupertinoPicker getPickerItems() {
  //   List<Text> pickerItems = [];
  //
  //   for (String currency in currenciesList) {
  //     pickerItems.add(Text(currency));
  //   }
  //
  //   return CupertinoPicker(
  //     backgroundColor: Colors.lightBlue,
  //     itemExtent: 32.0,
  //     children: pickerItems,
  //     onSelectedItemChanged: (selectedIndex) {
  //     },
  //   );
  // }

  DropdownButton androidList() {
    return DropdownButton<String>(
      value: selectedCurrencyOut,
      items: currenciesList.map((currency) {
        return DropdownMenuItem(
          child: Text(currency),
          value: currency,
        );
      }).toList(),
      onChanged: (value) async {
        var coinData = await exchange.getCoinData(selectedCurrencyOut, value!);
        updateUI(coinData);
        setState(() {
          selectedCurrencyOut = value;
          rate = coinData['rate'];
        });
      },
    );
  }

  DropdownButton androidListIn() {
    return DropdownButton<String>(
      value: selectedCurrencyIn,
      items: cryptoList.map((currency) {
        return DropdownMenuItem(
          child: Text(currency),
          value: currency,
        );
      }).toList(),
      onChanged: (value) async {
        var coinData = await exchange.getCoinData(selectedCurrencyIn, value!);
        updateUI(coinData);
        setState(() {
          selectedCurrencyIn = value;
          rate = coinData['rate'];
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      children: currenciesList.map((currency) {
        return Text(currency);
      }).toList(),
      onSelectedItemChanged: (selectedIndex) {
      },
    );
  }

  @override
  void initState() {
    super.initState();

    updateUI(widget.exchangeCoin);
  }

  void updateUI(dynamic coinData) {
    setState(() {
      if (coinData == null) {
        rate = 0;

        return;
      } else {
        rate = coinData['rate'];
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $selectedCurrencyIn = $rate $selectedCurrencyOut',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidListIn(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidList(),
          ),
        ],
      ),
    );
  }
}
