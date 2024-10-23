import 'dart:convert';
import 'package:http/http.dart' as http;

const url = 'https://rest.coinapi.io/v1/exchangerate/';
const apikey = '620e44dd-9678-49c4-b78f-70c201cfd5e6';

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
  Future<dynamic> getCoinData(String currency, String crypto) async {
    String uri = '$url$crypto/$currency?apikey=$apikey';
    print(uri);
    http.Response response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      var data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
