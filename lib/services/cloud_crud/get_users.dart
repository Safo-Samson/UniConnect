import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uniconnect/services/auth/auth_service.dart';
import 'package:uniconnect/services/cloud_crud/cloud_storage_exceptions.dart';
import 'package:uniconnect/widgets/user_profile.dart';
// import 'dart:developer' as devtols show log;

class FirebaseCloud {
  final allcourses = FirebaseFirestore.instance.collection('courses');
  final allUsers = FirebaseFirestore.instance.collection('users');
  final allNationalities =
      FirebaseFirestore.instance.collection('nationalities');
  final allresidences = FirebaseFirestore.instance.collection('residences');
  String currentUserId = AuthService.firebase().currentUser!.uid;

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
                  residents.isEmpty || residents.contains(user.residence);
              bool passCourseFilter =
                  courses.isEmpty || courses.contains(user.course);
              bool passYearFilter = years.isEmpty || years.contains(user.year);

              return passResidentFilter && passCourseFilter && passYearFilter
                  ? user
                  : null;
            })
            .where((user) => user != null)
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
                residents.isEmpty || residents.contains(user.residence);
            bool passCourseFilter =
                courses.isEmpty || courses.contains(user.course);
            bool passYearFilter = years.isEmpty || years.contains(user.year);

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







// Stream methods for real-time updates but not used in this project cah messes up the UI and the filters
  Stream<List<UserProfile>> getUsersWithNationalityStream(String nationality) {
    try {
      return allNationalities
          .doc(nationality.toLowerCase()) // Convert nationality to lowercase
          .collection('users')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => UserProfile.fromQuerySnapshot(doc))
              .toList());
    } catch (e) {
      throw CouldNotGetAllNationalityException();
    }
  }

  Stream<List<UserProfile>> getFilteredResultsStream(
    List<String> nationalities,
    List<String> residents,
    List<String> courses,
    List<String> years,
  ) {
    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> usersStream =
          allUsers.snapshots();

      return usersStream.map((snapshot) => snapshot.docs
              .map((doc) => UserProfile.fromQuerySnapshot(doc))
              .where((user) {
            bool passResidentFilter =
                residents.isEmpty || residents.contains(user.residence);
            bool passCourseFilter =
                courses.isEmpty || courses.contains(user.course);
            bool passYearFilter = years.isEmpty || years.contains(user.year);

            return passResidentFilter && passCourseFilter && passYearFilter;
          }).toList());
    } catch (e) {
      throw CouldNotGetAllNationalityException();
    }
  }


}
