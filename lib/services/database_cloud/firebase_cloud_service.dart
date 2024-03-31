import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uniconnect/my_trash/firestore_functions/add_initial_user_to_users.dart';
import 'package:uniconnect/services/auth/auth_service.dart';
import 'package:uniconnect/services/database_cloud/cloud_storage_exceptions.dart';
import 'package:uniconnect/services/database_cloud/database_provider.dart';
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
      // Reference to the users subcollection under the selected course
      CollectionReference usersCollection = FirebaseFirestore.instance
          .collection('courses')
          .doc(course)
          .collection('users');

      // Add the user's ID as a document in the subcollection
      await usersCollection.doc(userId).set({'userId': userId});

      devtols.log('User added to $course subcollection');
    } catch (e) {
      devtols.log('Error adding user to courses subcollection: $e');
    }
  }

  @override
  Future<void> addUserToNationalitySubcollection(
      String userId, String country) async {
    try {
      // Reference to the users subcollection under the selected country
      CollectionReference usersCollection = FirebaseFirestore.instance
          .collection('nationalities')
          .doc(country)
          .collection('users');

      // Add the user's ID as a document in the subcollection
      await usersCollection.doc(userId).set({'userId': userId});

      devtols.log('User added to $country subcollection');
    } catch (e) {
      devtols.log('Error adding user to nationality subcollection: $e');
    }
  }

  @override
  Future<void> addUserToResidenceSubcollection(
      String userId, String residence) async {
    try {
      // Reference to the users subcollection under the selected residence
      CollectionReference usersCollection = FirebaseFirestore.instance
          .collection('residence')
          .doc(residence)
          .collection('users');

      // Add the user's ID as a document in the subcollection
      await usersCollection.doc(userId).set({'userId': userId});

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
      // Step 1: Fetch user IDs from the specified nationality collection
      QuerySnapshot<Map<String, dynamic>> allUsersWithNationality =
          await allNationalities
              .doc(nationality) // Convert nationality to lowercase
              .collection('users')
              .get();

      List<String> userIds = allUsersWithNationality.docs
          .map((doc) => doc.id)
          .where((id) =>
              id != currentUserId) // Exclude current user's ID // Get user IDs
          .toList();

      // Step 2: Fetch user details from the users collection using the user IDs
      QuerySnapshot<Map<String, dynamic>> usersSnapshot =
          await allUsers.where(FieldPath.documentId, whereIn: userIds).get();

      // Step 3: Convert query snapshot to list of UserProfile objects
      Iterable<UserProfile> users = usersSnapshot.docs.map((userDoc) {
        return UserProfile.fromQuerySnapshot(userDoc);
      });

      return users;
    } catch (e) {
      throw CouldNotGetAllNationalityException();
    }
  }

  @override
  Future<Iterable<UserProfile>> getUsersWithCourse(String course) async {
    try {
      // Step 1: Fetch user IDs from the specified course collection
      QuerySnapshot<Map<String, dynamic>> allUsersWithCourse = await allcourses
          .doc(course) // Convert course to lowercase
          .collection('users')
          .get();

      List<String> userIds = allUsersWithCourse.docs
          .map((doc) => doc.id)
          .where((id) =>
              id != currentUserId) // Exclude current user's ID // Get user IDs
          .toList();

      // Step 2: Fetch user details from the users collection using the user IDs
      QuerySnapshot<Map<String, dynamic>> usersSnapshot =
          await allUsers.where(FieldPath.documentId, whereIn: userIds).get();

      // Step 3: Convert query snapshot to list of UserProfile objects
      Iterable<UserProfile> users = usersSnapshot.docs.map((userDoc) {
        return UserProfile.fromQuerySnapshot(userDoc);
      });

      return users;
    } catch (e) {
      throw CouldNotGetAllCoursesException();
    }
  }

  @override
  Future<Iterable<UserProfile>> getUsersWithResidence(String residence) async {
    try {
      // Step 1: Fetch user IDs from the specified residence collection
      QuerySnapshot<Map<String, dynamic>> allUsersWithResidence =
          await allresidences.doc(residence).collection('users').get();

      List<String> userIds = allUsersWithResidence.docs
          .map((doc) => doc.id)
          .where((id) =>
              id != currentUserId) // Exclude current user's ID // Get user IDs
          .toList();

      // Step 2: Fetch user details from the users collection using the user IDs
      QuerySnapshot<Map<String, dynamic>> usersSnapshot =
          await allUsers.where(FieldPath.documentId, whereIn: userIds).get();

      // Step 3: Convert query snapshot to list of UserProfile objects
      Iterable<UserProfile> users = usersSnapshot.docs.map((userDoc) {
        return UserProfile.fromQuerySnapshot(userDoc);
      });

      return users;
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
