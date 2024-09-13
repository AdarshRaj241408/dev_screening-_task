import 'package:flutter/material.dart';
import 'crypto_service.dart'; 

class CryptoScreen extends StatelessWidget {
  final CryptoService cryptoService = CryptoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Real-Time Crypto Prices'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: cryptoService.fetchCryptoPrices(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final cryptoPrices = snapshot.data!;
            final bitcoinPrice = cryptoPrices['bitcoin']['usd'];
            final ethereumPrice = cryptoPrices['ethereum']['usd'];

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Bitcoin: \$${bitcoinPrice.toStringAsFixed(2)}'),
                SizedBox(height: 10),
                Text('Ethereum: \$${ethereumPrice.toStringAsFixed(2)}'),
              ],
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
