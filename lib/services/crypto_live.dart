import 'package:flutter/material.dart';
import 'crypto_service.dart'; 

class CryptoScreen extends StatelessWidget {
  final CryptoService cryptoService = CryptoService();

  CryptoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real-Time Crypto Prices'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: cryptoService.fetchCryptoPrices(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
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
                const SizedBox(height: 10),
                Text('Ethereum: \$${ethereumPrice.toStringAsFixed(2)}'),
              ],
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
