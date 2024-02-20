import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as devtols show log;

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

Future<void> addUserToCoursesSubcollection(String userId, String course) async {
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
