import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:bitcoin_ticker/services/crypto_card.dart';

class PriceScreen extends StatefulWidget {

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String selectedCurrency = 'USD';
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
  DropdownButton androidDrop() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: currenciesList.map((currency) {
        return DropdownMenuItem(
          child: Text(currency),
          value: currency,
        );
      }).toList(),
      onChanged: (value) async {
        setState(() {
          selectedCurrency = value!;
          updateUI();
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
        selectedCurrency = currenciesList[selectedIndex];
        updateUI();
      },
    );
  }

  Map<String, String> coinPrices = {};
  bool checked = false;

  void updateUI() async {
    checked = true;
    try {
      var data = await CoinData().getCoinData(selectedCurrency);
      checked = false;
      setState(() {
        coinPrices = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    updateUI();
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
          Column(
            children: cryptoList.map((currency) {
              return CryptoCard(crypto: currency, rate: checked ? '?' : coinPrices[currency], selectedCurrency: selectedCurrency);
            }).toList(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDrop(),
          ),
        ],
      ),
    );
  }
}