import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uniconnect/services/auth/auth_exceptions.dart';
import 'package:uniconnect/services/auth/auth_service.dart';
import 'package:uniconnect/widgets/user_profile.dart';

String currentUserId = AuthService.currentAuthService().currentUser!.uid;
Future<Iterable<UserProfile>> getUsersWithField(
    String field, String value) async {
  try {
    // Step 1: Fetch user IDs from the specified field collection
    QuerySnapshot<Map<String, dynamic>> allUsersWithField =
        await FirebaseFirestore.instance
            .collection(field)
            .doc(value)
            .collection('users')
            .get();

    List<String> userIds = allUsersWithField.docs
        .map((doc) => doc.id)
        .where((id) => id != currentUserId) // Exclude current user's ID
        .toList();

    // Step 2: Fetch user details from the users collection using the user IDs
    QuerySnapshot<Map<String, dynamic>> usersSnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where(FieldPath.documentId, whereIn: userIds)
        .get();

    // Step 3: Convert query snapshot to list of UserProfile objects
    Iterable<UserProfile> users = usersSnapshot.docs.map((userDoc) {
      return UserProfile.fromQuerySnapshot(userDoc);
    });

    return users;
  } catch (e) {
    throw CouldNotGetUsersException();
  }
}
