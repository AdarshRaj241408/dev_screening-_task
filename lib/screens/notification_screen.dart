// lib/notification_screen.dart
import 'package:flutter/material.dart';
import 'package:trial_app/widgets/navigation_bar.dart';
import 'package:trial_app/services/nav_service.dart';
import 'package:trial_app/services/notif_service.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int _currentIndex = 3;
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Screen'),
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
            child: ElevatedButton(
              onPressed: () {
                NotificationService().showNotification(
                    title: 'Congratulations!',
                    body: 'Bitcoin prices are high!');
              },
              child: Text('Notification'),
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
