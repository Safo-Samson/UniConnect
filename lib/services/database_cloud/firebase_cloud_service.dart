import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uniconnect/my_trash/firestore_functions/add_initial_user_to_users.dart';
import 'package:uniconnect/services/auth/auth_service.dart';
import 'package:uniconnect/services/database_cloud/cloud_storage_exceptions.dart';
import 'package:uniconnect/services/database_cloud/database_provider.dart';
import 'package:uniconnect/utils/helpers_utilities/add_user_to_subcollection.dart';
import 'package:uniconnect/utils/helpers_utilities/get_users_with_field.dart';
import 'package:uniconnect/widgets/user_profile.dart';
import 'dart:developer' as devtols show log;

class FirebaseCloudService implements DatabaseProvider {
  final allcourses = FirebaseFirestore.instance.collection('courses');
  final allUsers = FirebaseFirestore.instance.collection('users');
  final allNationalities =
      FirebaseFirestore.instance.collection('nationalities');
  final allresidences = FirebaseFirestore.instance.collection('residence');
  String currentUserId = AuthService.currentAuthService().currentUser!.uid;

  @override
  Future<void> updateRequestedUsers(String userId) async {
    final userDocRef = allUsers.doc(currentUserId);
    try {
      // Get the user document
      final userDocSnapshot = await userDocRef.get();
      if (userDocSnapshot.exists) {
        // Check if the requestedUsers field exists in the document and update it
        if (userDocSnapshot.data()!['requestedUsers'] != null) {
          await userDocRef.update({
            'requestedUsers': FieldValue.arrayUnion([userId])
          });
        } else {
          // If the field doesn't exist, create it and set its value
          await userDocRef.set({
            'requestedUsers': [userId]
          }, SetOptions(merge: true));
        }
      } else {
        devtols.log('This user does not exist');
        CouldNotGetUser();
      }
    } catch (e) {
      CouldNotUpdateUserRecordException();
    }
  }

  @override
  Future<void> addUser(String userID, String email) {
    // Generate a username from the email
    final usernameFromEmail = email.split('@').first;
    final username = '$usernameFromEmail${generateRandomNumber()}';

    return allUsers.doc(userID).set({
      'username': username,
      'userId': userID,
    });
  }

  @override
  Future<void> addUserToCoursesSubcollection(
      String userId, String course) async {
    try {
      await addUserToSubcollection(userId, 'courses', course);
      devtols.log('User added to $course subcollection');
    } catch (e) {
      devtols.log('Error adding user to courses subcollection: $e');
    }
  }

  @override
  Future<void> addUserToNationalitySubcollection(
      String userId, String country) async {
    try {
      await addUserToSubcollection(userId, 'nationalities', country);

      devtols.log('User added to $country subcollection');
    } catch (e) {
      devtols.log('Error adding user to nationality subcollection: $e');
    }
  }

  @override
  Future<void> addUserToResidenceSubcollection(
      String userId, String residence) async {
    try {
      await addUserToSubcollection(userId, 'residence', residence);

      devtols.log('User added to $residence subcollection');
    } catch (e) {
      devtols.log('Error adding user to residence subcollection: $e');
    }
  }

  @override
  Future<List<UserProfile>> getFilteredResults(
    List<String> nationalities,
    List<String> residents,
    List<String> courses,
    List<String> years,
  ) async {
    try {
      List<UserProfile> filteredUsers = [];

      // Check if any filters are selected
      if (nationalities.isEmpty &&
          residents.isEmpty &&
          courses.isEmpty &&
          years.isEmpty) {
        throw Exception(
            "No filters selected.. Please select at least one filter.");
      }

      // Fetch all users if no filters other than nationalities are selected
      if (nationalities.isEmpty) {
        QuerySnapshot<Map<String, dynamic>> allUsersSnapshot =
            await allUsers.get();

        // Apply additional filters based on selected residents, courses, and years
        filteredUsers = allUsersSnapshot.docs
            .map((userDoc) {
              UserProfile user = UserProfile.fromQuerySnapshot(userDoc);
              bool passResidentFilter =
                  residents.isEmpty || residents.contains(user.getResidence);
              bool passCourseFilter =
                  courses.isEmpty || courses.contains(user.getCourse);
              bool passYearFilter =
                  years.isEmpty || years.contains(user.getYear);

              return passResidentFilter && passCourseFilter && passYearFilter
                  ? user
                  : null;
            })
            .where((user) => user != null && user.getUserId != currentUserId)
            .toList()
            .cast<UserProfile>();
      } else {
        // Iterate through selected nationalities
        for (String nationality in nationalities) {
          Iterable<UserProfile> users =
              await getUsersWithNationality(nationality);

          // Apply additional filters based on selected residents, courses, and years
          users = users.where((user) {
            bool passResidentFilter =
                residents.isEmpty || residents.contains(user.getResidence);
            bool passCourseFilter =
                courses.isEmpty || courses.contains(user.getCourse);
            bool passYearFilter = years.isEmpty || years.contains(user.getYear);

            return passResidentFilter && passCourseFilter && passYearFilter;
          });

          // Add filtered users to the list
          filteredUsers.addAll(users);
        }
      }

      return filteredUsers;
    } catch (e) {
      throw CouldNotGetAllNationalityException();
    }
  }




  @override
  Future<Iterable<UserProfile>> getUsersWithNationality(
      String nationality) async {
    try {
      return getUsersWithField('nationalities', nationality);
    } catch (e) {
      throw CouldNotGetAllNationalityException();
    }
  }

  @override
  Future<Iterable<UserProfile>> getUsersWithCourse(String course) async {
    try {
      return getUsersWithField('courses', course);
    } catch (e) {
      throw CouldNotGetAllCoursesException();
    }
  }

  @override
  Future<Iterable<UserProfile>> getUsersWithResidence(String residence) async {
    try {
      return getUsersWithField('residence', residence);
    } catch (e) {
      throw CouldNotGetAllResidenceException();
    }
  }

  @override
  Future<void> updateUserInfo(
      String userId, Map<String, dynamic> dataToUpdate) async {
    try {
      DocumentReference userRef = allUsers.doc(userId);
      await userRef.update(dataToUpdate);

      devtols.log('User document updated successfully');
    } catch (e) {
      devtols.log('Error updating user document: $e');
    }
  }
  
  @override
  Future<List<UserProfile>> queryUsersWithSimilarProfiles(
      UserProfile currentUserProfile) {
    // TODO: implement queryUsersWithSimilarProfiles
    throw UnimplementedError();
  }
}
