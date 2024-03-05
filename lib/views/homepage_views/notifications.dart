import 'package:flutter/material.dart';
import 'package:uniconnect/widgets/notification_item.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<NotificationItem> notifications = [
    // NotificationItem(
    //   message: "You may know Ebenexer, he studies computer science.",
    //   watched: false,
    // ),
    // NotificationItem(
    //   message: "Pierre sent you a connection request with an ice breaker.",
    //   watched: true,
    // ),
  ];

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
