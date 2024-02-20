import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:math';
import 'dart:developer' as devtols show log;

// Function to generate a random number between 1000 and 9999
int generateRandomNumber() {
  final random = Random();
  return random.nextInt(9000) + 1000;
}

// Get reference to Firestore collection
final CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('users');

// Function to store user data in Firestore
Future<void> addUser({
  required String userID,
  required String email,
}) async {
  // Generate a username from the email
  final usernameFromEmail = email.split('@').first;
  final username = '$usernameFromEmail${generateRandomNumber()}';

  await usersCollection.doc(userID).set({
    'username': username,
    'userId': userID,
    // Add more fields as needed
  });
}

Future<void> updateUserWithYear(
    String userId, Map<String, dynamic> dataToUpdate) async {
  try {
    // Reference to the document in the 'users' collection
    DocumentReference userRef = usersCollection.doc(userId);
    // Update the document with the new data
    await userRef.update(dataToUpdate);

    devtols.log('User document updated successfully');
  } catch (e) {
    devtols.log('Error updating user document: $e');
  }
}


Future<void> addUserToGeneralCollection(String userId, String course,
    String nationality, String residence, String year) async {
  try {

    if (nationality.length > 1) {
      // Split the nationality because it contains two words, first as flag
      List<String> parts = nationality.split(' ');

      // Assign the second word to the nationality variable
      nationality = parts[1];
    }

    // Reference to the users subcollection under the selected course
    CollectionReference generalUsersCollection =
        FirebaseFirestore.instance.collection('GeneralUsers');

    // Add the user's ID as a document in the subcollection
    await generalUsersCollection.doc(userId).set({
      'userId': userId,
      'course': course,
      'nationality': nationality,
      'residence': residence,
      'year': year,
    });
    devtols.log('User added to GeneralUsers subcollection');
  } catch (e) {
    devtols.log('Error adding user to courses subcollection: $e');
  }
}
