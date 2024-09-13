// lib/notification_screen.dart
import 'package:flutter/material.dart';
import 'package:trial_app/widgets/navigation_bar.dart';
import 'package:trial_app/services/nav_service.dart';
import 'package:trial_app/services/notif_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

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
        title: const Text('Notification Screen'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/def_bg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 250.0,
                  height: 250.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.blueAccent, // Border color
                      width: 4.0, // Border width
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/notif_icon.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: SizedBox(
                  width: 350,
                  height: 140,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 30),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.black.withOpacity(0.5),
                      elevation: 10, // Shadow elevation
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      NotificationService().showNotification(
                          title: 'Congratulations!',
                          body: 'Bitcoin prices are high!');
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF56CCF2),
                            Color(0xFF2F80ED)
                          ], // Gradient colors
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        alignment: Alignment.center,
                        child: const Text(
                          'Show Notification',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
