import 'package:flutter/material.dart';
import 'package:trial_app/screens/crypto_screen.dart';
import 'package:trial_app/screens/list_screen.dart';
import 'package:trial_app/screens/notification_screen.dart';
import 'package:trial_app/services/nav_service.dart';
import 'package:trial_app/services/notif_service.dart';
import 'package:trial_app/screens/image_switcher_screen.dart';
import 'package:trial_app/screens/main_screen.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: MainPage(),
      navigatorKey: NavService.navigatorKey,
      routes: {
        '/list': (context) => ListScreen(),
        '/imageSwitcher': (context) => ImageSwitcherScreen(),
        '/crypto': (context) => CryptoScreen(),
        '/notifications': (context) => NotificationScreen(),
      },
    );
  }
}
