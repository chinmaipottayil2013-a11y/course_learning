import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> fireBaseBackgroundHandler(RemoteMessage message) async {}

class PushNotificationsService {
  PushNotificationsService._();
  static final PushNotificationsService instance = PushNotificationsService._();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    await _notificationsPlugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
    );
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_androidNotificationChannel);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final title = message.notification?.title ?? message.data['title'];
      final body = message.notification?.body ?? message.data['body'];
      _showBanner(title, body, payload: jsonEncode(message.data));
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      final RemoteMessage? initialMessage = await _firebaseMessaging
          .getInitialMessage();

      if (initialMessage != null) {}
    });
  }

  void showLocal({required String title, required String body}) {
    _showBanner(title, body);
  }

  void _showBanner(String? title, String? body, {String payload = '{}'}) {
    if (title == null && body == null) return;
    _notificationsPlugin.show(
      id: DateTime.now().microsecondsSinceEpoch.remainder(100000),
      title: title,
      body: body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _androidNotificationChannel.id,
          _androidNotificationChannel.name,
          channelDescription: _androidNotificationChannel.description,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      payload: payload,
    );
  }

  static const AndroidNotificationChannel _androidNotificationChannel =
      AndroidNotificationChannel(
        'high-importance_channel',
        'High Importance Channel',
        importance: Importance.high,
      );
  Future<String?> getToken() {
    return _firebaseMessaging.getToken();
  }
}
