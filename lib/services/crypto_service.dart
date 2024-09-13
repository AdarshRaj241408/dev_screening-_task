import 'dart:convert';
import 'package:http/http.dart' as http;

class CryptoService {
  final String apiUrl =
      'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum&vs_currencies=usd';

  Future<Map<String, dynamic>> fetchCryptoPrices() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load crypto prices');
    }
  }
}
