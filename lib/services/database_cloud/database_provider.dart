import 'package:uniconnect/widgets/user_profile.dart';

abstract class DatabaseProvider {
  Future<void> addUser(String userID, String email);

  Future<void> updateUserInfo(String userId, Map<String, dynamic> dataToUpdate);

  Future<Iterable<UserProfile>> getUsersWithResidence(String residence);

  Future<Iterable<UserProfile>> getUsersWithCourse(String course);

  Future<Iterable<UserProfile>> getUsersWithNationality(String nationality);

  Future<List<UserProfile>> getFilteredResults(
    List<String> nationalities,
    List<String> residents,
    List<String> courses,
    List<String> years,
  );

  Future<void> addUserToNationalitySubcollection(
    String userId,
    String country,
  );

  Future<void> addUserToResidenceSubcollection(
    String userId,
    String residence,
  );

  Future<void> addUserToCoursesSubcollection(
    String userId,
    String course,
  );

  Future<void> updateRequestedUsers(String userId);
}
