import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uniconnect/services/cloud_crud/cloud_storage_exceptions.dart';
import 'package:uniconnect/widgets/user_profile.dart';
// import 'dart:developer' as devtols show log;

class FirebaseCloud {
  final allcourses = FirebaseFirestore.instance.collection('courses');
  final allUsers = FirebaseFirestore.instance.collection('users');
  final allNationalities =
      FirebaseFirestore.instance.collection('nationalities');
  final allresidences = FirebaseFirestore.instance.collection('residences');

  void getAllUsers() async {}

  Future<Iterable<UserProfile>> getUsersWithNationality(
      String nationality) async {
    try {
      // Step 1: Fetch user IDs from the specified nationality collection
      QuerySnapshot<Map<String, dynamic>> allUsersWithNationality =
          await allNationalities
              .doc(nationality) // Convert nationality to lowercase
              .collection('users')
              .get();

      List<String> userIds = allUsersWithNationality.docs
          .map((doc) => doc.id) // Get user IDs
          .toList();

      // Step 2: Fetch user details from the users collection using the user IDs
      QuerySnapshot<Map<String, dynamic>> usersSnapshot =
          await allUsers.where(FieldPath.documentId, whereIn: userIds).get();

      // Step 3: Convert query snapshot to list of UserProfile objects
      Iterable<UserProfile> users = usersSnapshot.docs.map((userDoc) {
        return UserProfile.fromSnapshot(userDoc);
      });

      return users;
    } catch (e) {
      throw CouldNotGetAllNationalityException();
    }
  }

  void getUsersWithCourse(String course) async {}

  void getUsersWithResidence(String residence) async {}

  Future<String> getUserNationality(String userId) async {
    try {
      String userNationality = await allUsers
          .doc(userId)
          .get()
          .then((value) => value.data()!['nationality']);

      return userNationality;
    } catch (e) {
      throw CouldNotGetUser();
    }
  }

}
