import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    // Initialize Android settings
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
      'flutter_logo',
    ); // Ensure this icon exists in your drawable directory

    final Logger _logger = Logger();

    // Initialize iOS settings
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {},
    );

    // Linux settings (if needed)
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');

    // Combine initialization settings for all platforms
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      linux: initializationSettingsLinux,
    );

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        // Handle the notification response
        _logger.i(
            'Notification tapped with payload: ${notificationResponse.payload}');
        // Navigate to the desired screen or perform other actions
      },
    );
  }

  NotificationDetails notificationDetails() {
    // Android notification details
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'Adarsh', // Unique channel ID
      'Warrior', // Channel name
      channelDescription: 'yoyoyoyoyoyoyoy', // Channel description
      importance: Importance.max,
      priority: Priority.high,
      playSound: true, // Ensure sound plays
    );

    // iOS notification details
    const DarwinNotificationDetails iOSNotificationDetails =
        DarwinNotificationDetails();

    return const NotificationDetails(
      android: androidNotificationDetails,
      iOS: iOSNotificationDetails,
    );
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    await notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails(),
      payload: payload,
    );
  }
}
