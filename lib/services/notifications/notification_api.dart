// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer' as devtols show log;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uniconnect/constants/routes.dart';
import 'package:uniconnect/main.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  devtols.log('Handling a background message ${message.messageId}');
  print(message.notification?.title);
  print(message.notification?.body);
  devtols.log(message.data.toString());
}

class NotificationApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  // to create notification channel for android
  final _androidNotificationChannel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void handleMessages(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState!
        .pushNamed(notificationRouteFromTap, arguments: message);
  }

  Future<void> initializeNotifications() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    final token = await _firebaseMessaging.getToken();
    devtols.log('FirebaseMessaging token: $token');
    initPushNotification();
    initLocalNotifications();
  }

  Future initLocalNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = IOSInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: iOS);
    await _localNotificationsPlugin.initialize(settings,
        onSelectNotification: (payload) async {
      if (payload == null) return;
      final message = RemoteMessage.fromMap(jsonDecode(payload));
      handleMessages(message);
    });

    final platform =
        _localNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!;
    await platform.createNotificationChannel(_androidNotificationChannel);
  }

  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

// Get any messages which caused the application to open from terminated state via notification
    FirebaseMessaging.instance.getInitialMessage().then(handleMessages);
    // when the app is in the foreground and opened and user taps on the notification
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessages);
    // when the app is in the background but opened and user taps on the notification
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    // when the app is in the foreground and opened and user taps on the notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification == null) return;

      _localNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidNotificationChannel.id,
            _androidNotificationChannel.name,
            channelDescription: _androidNotificationChannel.description,
            importance: Importance.high,
            icon: '@mipmap/ic_launcher', // Change this to your app icon
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }
}
