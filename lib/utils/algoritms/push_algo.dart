import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uniconnect/constants/ice_breaker_messages.dart';
import 'package:uniconnect/services/database_cloud/database_service.dart';
import 'package:uniconnect/services/notifications/notification_sender_service.dart';
import 'package:uniconnect/widgets/user_profile.dart';

class ActiveConnectionNotifications {
 
  final UserProfile _currentUserProfile;
  ActiveConnectionNotifications(this._currentUserProfile);

  Future<void> sendConnectionNotifications() async {

    DateTime now = DateTime.now();
    DateTime academicYearStartDate = getAcademicYearStartDate();
    DateTime activeUniversityDates =
        academicYearStartDate.add(const Duration(days: 60)); 

    if (now.isAfter(academicYearStartDate) &&
        now.isBefore(activeUniversityDates)) {
      List<UserProfile> similarUsers =
          await DatabaseService.currentDatabaseService()
              .queryUsersWithSimilarProfiles(_currentUserProfile);

      for (UserProfile otherUser in similarUsers) {
        if (!isConnected(_currentUserProfile, otherUser)) {
          sendNotificationWithIceBreaker(otherUser, _currentUserProfile);
        }
      }
    }
  }

  bool isConnected(UserProfile user1, UserProfile user2) {
    return user1.getRequestedUsers.contains(user2.getUserId) ||
        user2.getRequestedUsers.contains(user1.getUserId);
  }

  DateTime getAcademicYearStartDate() {
    return DateTime(DateTime.now().year, 9, 1);
  }

  Future<void> sendNotificationWithIceBreaker(
      UserProfile user, UserProfile currentUserProfile) async {
    IceBreakerGenerator iceBreakerGenerator =
        IceBreakerGenerator(user, currentUserProfile);

    String iceBreakerMessage = iceBreakerGenerator.generateCommentOnTopic();

// shoudl be sendConfirmationNotificationOnConnectWithBreaker2 instead of sendConfirmationNotificationOnConnectWithBreaker
    NotificationSenderService.currentNotificationService()
        .sendConfirmationNotificationOnConnectWithBreaker(
            user.getUserId, iceBreakerMessage);

    NotificationSenderService.currentNotificationService()
        .sendConfirmationNotificationOnConnectWithBreaker(
            currentUserProfile.getUserId, iceBreakerMessage);
  }

  
  Future<List<UserProfile>> queryUsersWithSimilarProfiles(
      UserProfile currentUserProfile) async {
    // Implement database query to find users with similar profiles
    // You can query based on attributes like course, year, residence, etc.
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('course', isEqualTo: currentUserProfile.getCourse)
        .where('year', isEqualTo: currentUserProfile.getYear)
        .where('residence', isEqualTo: currentUserProfile.getResidence)
        .get();
    List<UserProfile> similarUsers = [];
    for (var doc in querySnapshot.docs) {
      similarUsers.add(UserProfile.fromQuerySnapshot(
          doc as QueryDocumentSnapshot<Map<String, dynamic>>));
    }
    return similarUsers;
  }


}
