import 'package:http/http.dart' as http;
import "dart:convert";

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
  'ZAR',
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
  "USDT",
  "BNB",
  "XRP",
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'B31D7BED-DA8D-4E25-9E9C-FDDAE3098B57';

class CoinData{
  Future getCoinData (String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList){
      Uri requestURL = Uri.parse("$coinAPIURL/$crypto/$selectedCurrency?apiKey=$apiKey");
      http.Response response = await http.get(requestURL);
      if(response.statusCode == 200){
        var decodedData = jsonDecode(response.body);
        double price = decodedData["rate"];
        //In this below code, we are setting the value for the key, Crypto (BTC) is consider the key and price is the value.
        cryptoPrices[crypto] = price.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}

// void main() async {
//   CoinData coinData = CoinData(); // Create an instance of CoinData
//   final result = await coinData.getCoinData("USD");
//   print(result);
//
// }
//
//
