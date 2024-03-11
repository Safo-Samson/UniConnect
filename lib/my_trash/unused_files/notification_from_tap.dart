import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:uniconnect/utils/Brand/brand_colours.dart';
import 'package:uniconnect/utils/Brand/brand_fonts.dart';
import 'package:uniconnect/utils/Brand/spaces.dart';

class NotificationPageFromTap extends StatefulWidget {
  final RemoteMessage message;

  const NotificationPageFromTap({Key? key, required this.message})
      : super(key: key);

  @override
  State<NotificationPageFromTap> createState() =>
      _NotificationPageFromTapState();
}

class _NotificationPageFromTapState extends State<NotificationPageFromTap> {
  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Notification'),
        backgroundColor: BrandColor.primary, // Change app bar color
        elevation: 0, // Remove app bar shadow
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${message.notification?.title}',
              style: TextStyle(
                fontSize: BrandFonts.h2,
                color: BrandColor.primary,
              ),
            ),
            verticalSpace(20),
            Text(
              '${message.notification?.body}',
              style: const TextStyle(
                fontSize: BrandFonts.regularText,
              ),
            ),
            verticalSpace(20),
            Text(
              '${message.data}',
              style: const TextStyle(
                fontSize: BrandFonts.regularText,
                fontStyle: FontStyle.italic, // Apply italic style
                color: Colors.grey, // Change text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
