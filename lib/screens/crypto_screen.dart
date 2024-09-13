// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:trial_app/services/nav_service.dart';
import '../services/crypto_service.dart';
import '../widgets/navigation_bar.dart';

class CryptoScreen extends StatefulWidget {
  const CryptoScreen({super.key});

  @override
  _CryptoScreenState createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  final CryptoService cryptoService = CryptoService();
  int _currentIndex = 2;

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        NavService.navigateTo('/list');
        break;
      case 1:
        NavService.navigateTo('/imageSwitcher');
        break;
      case 2:
        NavService.navigateTo('/crypto');
        break;
      case 3:
        NavService.navigateTo('/notifications');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Crypto Prices'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://i.pinimg.com/564x/90/9a/d2/909ad238365dbdd7ee088110a24edb39.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: FutureBuilder<Map<String, dynamic>>(
              future: cryptoService.fetchCryptoPrices(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final cryptoPrices = snapshot.data!;
                  final cryptoList = cryptoPrices.entries.map((entry) {
                    final cryptoName = entry.key;
                    final cryptoPrice = entry.value['usd'];
                    return ListTile(
                      title: Text(
                        cryptoName.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 19),
                      ),
                      subtitle: Text(
                        '\$${cryptoPrice.toStringAsFixed(2)}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList();

                  return Container(
                    constraints: BoxConstraints(
                      minHeight: screenHeight,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 120,
                        ),
                        Container(
                          width: 250.0,
                          height: 250.0,
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.blueAccent,
                              width: 4.0,
                            ),
                          ),
                          child: ClipOval(
                            child: Image.network(
                              'https://i.pinimg.com/564x/f8/40/0c/f8400c36c335cf6812c1b2e76d69ef0c.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(16.0),
                            children: cryptoList,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavItemTapped,
      ),
    );
  }
}
