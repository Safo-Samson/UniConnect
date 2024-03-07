import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:uniconnect/constants/notification_list.dart';
import 'package:uniconnect/main.dart';
import 'package:uniconnect/utils/Brand/brand_colours.dart';

import 'package:uniconnect/utils/unamed_utilities/unique_id.dart';
import 'package:uniconnect/views/homepage_views/notifications.dart';
import 'package:uniconnect/widgets/notification_item.dart';
import 'dart:developer' as devtols show log;

class MyAwesomeNotification {
  static Future<void> initializeAwesomeNotifications() async {
    await AwesomeNotifications().initialize(
      null, // no icon for the notification
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: BrandColor.primary,
          ledColor: Colors.white,
          importance: NotificationImportance.High,
          playSound: true,
          channelShowBadge: true,
        ),
      ],
    );
  }

  static Future<void> sendConfirmationNotificationOnConnect(String user) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueID(),
        channelKey: 'basic_channel',
        title: 'Request Sent',
        body: 'You have sent a connection request to the $user',
      ),
    );

    addNotification('You have sent a connection request to the $user');
  }

  static void addNotification(String message) {
    notifications.insert(0, NotificationItem(message: message, watched: false));
    devtols.log('Notification added to list ');
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here

    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
        '/notification-page',
        (route) =>
            (route.settings.name != '/notification-page') || route.isFirst,
        arguments: receivedAction);
  }

// does not work
  // @pragma('vm:entry-point')
  // static Future<void> onActionReceivedImplementationMethod(
  //     ReceivedAction receivedAction) async {
  //   devtols.log('Action received: ${receivedAction.buttonKeyPressed}');
  //   navigatorKey.currentState?.push(MaterialPageRoute(
  //     builder: (_) => NotificationPage(),
  //   ));
  // }
}
