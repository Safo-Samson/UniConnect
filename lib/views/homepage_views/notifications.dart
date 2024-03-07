import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:uniconnect/constants/notification_list.dart';
import 'package:uniconnect/utils/Brand/brand_colours.dart';


class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Notifications are disabled'),
              content: const Text(
                  'Please enable notifications to receive updates and important information.'),
              actions: [
                TextButton(
                  onPressed: () {
                    AwesomeNotifications()
                        .requestPermissionToSendNotifications()
                        .then((_) => Navigator.pop(context));
                  },
                  child: Text(
                    'Allow',
                    style: TextStyle(
                        color: BrandColor.primary, fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Don't Allow",
                      style: TextStyle(color: BrandColor.grey),
                    )),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {


    int unwatchedCount = notifications.where((item) => !item.watched).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Chip(
              backgroundColor: Colors.red, // Customize color as needed
              label: Text(
                unwatchedCount
                    .toString(), // Display the count of unwatched notifications
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off,
                    size: 50,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'You currently have no notifications.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        notification.message,
                        style: TextStyle(
                          fontWeight: notification.watched
                              ? FontWeight.normal
                              : FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        // Handle tapping on the notification
                        // You can mark the notification as watched here
                      },
                    ),
                    const Divider(
                      thickness: 1,
                    ), // Add a divider after each notification
                  ],
                );
              },
            ),
    );
  }
}
