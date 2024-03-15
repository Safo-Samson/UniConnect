import 'package:uniconnect/services/database_cloud/database_provider.dart';
import 'package:uniconnect/services/database_cloud/firebase_cloud_service.dart';
import 'package:uniconnect/widgets/user_profile.dart';

class DatabaseService implements DatabaseProvider {
  final DatabaseProvider _datbaseProvider;

  const DatabaseService(this._datbaseProvider);

  factory DatabaseService.currentDatabaseService() =>
      DatabaseService(FirebaseCloudService());

  @override
  Future<void> addUser(String userID, String email) {
    return _datbaseProvider.addUser(userID, email);
  }

  @override
  Future<void> addUserToCoursesSubcollection(String userId, String course) {
    return _datbaseProvider.addUserToCoursesSubcollection(userId, course);
  }

  @override
  Future<void> addUserToNationalitySubcollection(
      String userId, String country) {
    return _datbaseProvider.addUserToNationalitySubcollection(userId, country);
  }

  @override
  Future<void> addUserToResidenceSubcollection(
      String userId, String residence) {
    return _datbaseProvider.addUserToResidenceSubcollection(userId, residence);
  }

  @override
  Future<List<UserProfile>> getFilteredResults(List<String> nationalities,
      List<String> residents, List<String> courses, List<String> years) {
    return _datbaseProvider.getFilteredResults(
        nationalities, residents, courses, years);
  }

  @override
  Future<Iterable<UserProfile>> getUsersWithNationality(String nationality) {
    return _datbaseProvider.getUsersWithNationality(nationality);
  }

  @override
  Future<void> updateUserInfo(
      String userId, Map<String, dynamic> dataToUpdate) {
    return _datbaseProvider.updateUserInfo(userId, dataToUpdate);
  }
  
  @override
  Future<void> updateRequestedUsers(String userId) {
    return _datbaseProvider.updateRequestedUsers(userId);
  }
}
