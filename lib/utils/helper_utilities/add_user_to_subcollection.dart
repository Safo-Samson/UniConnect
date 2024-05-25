import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as devtols show log;

Future<void> addUserToSubcollection(
    String userId, String field, String value) async {
  try {
    // Reference to the users subcollection under the selected field
    CollectionReference usersCollection = FirebaseFirestore.instance
        .collection(field)
        .doc(value)
        .collection('users');

    // Add the user's ID as a document in the subcollection
    await usersCollection.doc(userId).set({'userId': userId});

    devtols.log('User added to $value subcollection in $field');
  } catch (e) {
    devtols.log('Error adding user to $field subcollection: $e');
  }
}
