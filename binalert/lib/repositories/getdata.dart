import 'dart:convert';
import 'package:binalert/models/crypto.dart';
import 'package:http/http.dart' as http;

class CryptoService {
  static const String apiKey = 'cc6c147d-1903-4635-835d-1c7ef4240f8a';

  Future<Crypto?> getCryptoData(String symbol) async {
    final String url =
        'https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest?symbol=$symbol';

    final Map<String, String> headers = {
      'Accept': 'application/json',
      'X-CMC_PRO_API_KEY': apiKey,
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
  final Map<String, dynamic> data = json.decode(response.body);
  if (data['status']['error_code'] == 0) {
    final Map<String, dynamic>? cryptoData = data['data'][symbol]; 
    if (cryptoData != null) {
      //print(Crypto.fromJson(cryptoData));
      return Crypto.fromJson(cryptoData);
    } else {
      print('Crypto data for "BTC" not found');
      return null;
    }
  } else {
    print('API error: ${data['status']['error_message']}');
    return null;
  }
} else {
  print('HTTP error ${response.statusCode}: ${response.body}');
  return null;
}

  }
}

// Example usage
void main() async {
  final cryptoService = CryptoService();
  final cryptoData = await cryptoService.getCryptoData('BTC');
  print(cryptoData?.toJson());
}
