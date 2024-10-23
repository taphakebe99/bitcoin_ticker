import 'package:bitcoin/coin_data.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();

  double BTCrate = 0.0;
  double ETHrate = 0.0;
  double LTCrate = 0.0;

  String selectedValue = currenciesList.first;

  @override
  void initState() {
    super.initState();
    updateUI(); // Initial call to fetch data when the widget is created
  }

  DropdownButton<String> androidDropdownPicker() {
    List<DropdownMenuItem<String>> items =
        currenciesList.map((String currency) {
      return DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
    }).toList();

    return DropdownButton<String>(
      value: selectedValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        setState(() {
          selectedValue = value!;
          updateUI(); // Update UI whenever the selected currency changes
        });
      },
      items: items,
    );
  }

  Future<void> updateUI() async {
    try {
      final responses = await Future.wait([
        coinData.getCoinData(selectedValue, cryptoList.first),
        coinData.getCoinData(selectedValue, cryptoList[1]),
        coinData.getCoinData(selectedValue, cryptoList.last),
      ]);

      setState(() {
        BTCrate = responses[0]?['rate'] ?? BTCrate;
        ETHrate = responses[1]?['rate'] ?? ETHrate;
        LTCrate = responses[2]?['rate'] ?? LTCrate;
      });
    } catch (e) {
      print('Failed to fetch data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
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
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ${BTCrate.toInt()} $selectedValue',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = ${ETHrate.toInt()} $selectedValue',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = ${LTCrate.toInt()} $selectedValue',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
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
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: androidDropdownPicker(),
          ),
        ],
      ),
    );
  }
}
