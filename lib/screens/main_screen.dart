import 'package:flutter/material.dart';
import 'package:trial_app/services/nav_service.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
        backgroundColor: Colors.grey[900],
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://i.pinimg.com/564x/75/07/03/7507034c72ebbf917ecadcad1e61df9b.jpg'),
            fit: BoxFit.cover, // Fills the background
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.7),
              BlendMode.darken,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end, // Align to the bottom
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  _buildNavBox(context, Icons.list, 'List Screen', '/list'),
                  _buildNavBox(
                      context, Icons.image, 'Image Switcher', '/imageSwitcher'),
                  _buildNavBox(context, Icons.monetization_on, 'Crypto Screen',
                      '/crypto'),
                  _buildNavBox(context, Icons.notifications, 'Notifications',
                      '/notifications'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavBox(
      BuildContext context, IconData icon, String label, String route) {
    return GestureDetector(
      onTap: () {
        NavService.navigateTo(route);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: const Color.fromARGB(204, 35, 165, 216).withOpacity(0.5),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 40, color: const Color.fromARGB(204, 35, 165, 216)),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
