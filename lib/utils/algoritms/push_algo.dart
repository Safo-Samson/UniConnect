import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uniconnect/constants/ice_breaker_messages.dart';
import 'package:uniconnect/widgets/user_profile.dart';

class ActiveConnectionNotifications {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> sendConnectionNotifications(
      UserProfile currentUserProfile) async {
    // Check if the current date is within the important timeframe (e.g., first month or two of the start of the academic year)
    DateTime now = DateTime.now();
    DateTime academicYearStartDate = getAcademicYearStartDate();
    DateTime activeUniversityDates = academicYearStartDate.add(const Duration(
        days:
            60)); // Assuming the important timeframe is the first two months of the academic year

    if (now.isAfter(academicYearStartDate) &&
        now.isBefore(activeUniversityDates)) {
      // Within the important timeframe
      List<UserProfile> similarUsers =
          await queryUsersWithSimilarProfiles(currentUserProfile);

      for (UserProfile user in similarUsers) {
        if (!isConnected(currentUserProfile, user)) {
          sendNotificationWithIceBreaker(user, currentUserProfile);
        }
      }
    }
  }

  Future<List<UserProfile>> queryUsersWithSimilarProfiles(
      UserProfile currentUserProfile) async {
    // Implement database query to find users with similar profiles
    // You can query based on attributes like course, year, residence, etc.
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('course', isEqualTo: currentUserProfile.course)
        .where('year', isEqualTo: currentUserProfile.year)
        .where('residence', isEqualTo: currentUserProfile.residence)
        .get();
    List<UserProfile> similarUsers = [];
    for (var doc in querySnapshot.docs) {
      similarUsers.add(UserProfile.fromQuerySnapshot(
          doc as QueryDocumentSnapshot<Map<String, dynamic>>));
    }
    return similarUsers;
  }

  bool isConnected(UserProfile user1, UserProfile user2) {
    // Implement logic to check if user1 is already connected with user2
    // You can check if user2 is present in user1's list of requested connections
    return user1.requestedUsers.contains(user2.userId);
  }

  Future<void> sendNotificationWithIceBreaker(
      UserProfile user, UserProfile currentUserProfile) async {
    IceBreakerGenerator iceBreakerGenerator =
        IceBreakerGenerator(user, currentUserProfile);

    String iceBreakerMessage = iceBreakerGenerator.generateCommentOnTopic();

    // Implement notification sending mechanism
    // You can use email, push notifications, or any other communication channel
    String notificationMessage =
        "Connect with ${user.username} to make new friends!";
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Connection Notification',
      '$notificationMessage\n$iceBreakerMessage',
      platformChannelSpecifics,
      payload: 'Custom_Sound',
    );
  }

  DateTime getAcademicYearStartDate() {
    // Implement this function to get the start date of the academic year
    // You can fetch the start date from a database or use a predefined value
    // For demonstration, let's assume the academic year starts on September 1st
    return DateTime(DateTime.now().year, 4, 1);
  }
}
