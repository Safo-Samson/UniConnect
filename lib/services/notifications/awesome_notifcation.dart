import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:uniconnect/constants/notification_list.dart';
import 'package:uniconnect/utils/Brand/brand_colours.dart';
import 'package:uniconnect/utils/unamed_utilities/unique_id.dart';
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
        body: 'You have sent a connection request to $user',
      ),
    );

    addNotification('You have sent a connection request to the $user');
  }

  static Future<void> sendConfirmationNotificationOnConnectWithBreaker(
      String user, String breakerMessage) async {
    // Truncate the breakerMessage to a maximum number of words
    String truncatedMessage = truncateMessage(
        breakerMessage, 9); // Change 20 to your desired maximum number of words

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueID(),
        channelKey: 'basic_channel',
        title: 'Request Sent',
        body:
            'You have sent a connection request to $user with the message: $truncatedMessage',
      ),
    );

    addNotification(
        'You have sent a connection request to $user with the message: $truncatedMessage');
  }

// Function to truncate a message to a maximum number of words
  static String truncateMessage(String message, int maxWords) {
    List<String> words = message.split(' ');
    if (words.length <= maxWords) {
      return message;
    } else {
      return '${words.sublist(0, maxWords).join(' ')}...';
    }
  }

  static void addNotification(String message) {
    notifications.insert(0, NotificationItem(message: message, watched: false));
    devtols.log('Notification added to list ');
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

// class SendNotification {
//   final NotificationSender _notificationSender;

//   SendNotification(this._notificationSender);

//   Future<void> sendNotification(String title, String body) async {
//     await _notificationSender.sendNotification(title, body);
//   }
// }

// abstract class NotificationSender {
//   Future<void> sendNotification(String title, String body);
// }

// class FirebaseNotificationSender implements NotificationSender {
//   @override
//   Future<void> sendNotification(String title, String body) async {
    
//   }
// }

// class MockNotificationSender implements NotificationSender {
//   @override
//   Future<void> sendNotification(String title, String body) async {
//     log(1, 'Mock notification sent: $title, $body');
//   }
// }
