import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as devtols show log;
import 'package:uniconnect/utils/TestData/test_data.dart';

// not used in the app
Future<void> main() async {
  // Initialize Firebase
  await Firebase.initializeApp();
  // Reference to the Firestore instance
  final firestore = FirebaseFirestore.instance;

  try {
    // Loop through the list of countries and add documents to the 'nationalities' collection
    for (String country in testDataCountries) {
      // Add a document representing the country under the 'nationalities' collection
      await firestore.collection('nationalities').doc(country).set({
        'name': country,
      });

      for (String course in testDataCourses) {
        // Add a document representing the course under the 'courses' collection
        await firestore.collection('courses').doc(course).set({
          'name': course,
        });
      }

      for (String resident in testDataResidents) {
        // Add a document representing the resident under the 'residents' collection
        await firestore.collection('residents').doc(resident).set({
          'name': resident,
        });
      }
    }

    devtols.log('All documents added successfully!');
  } catch (e) {
    devtols.log('Error: $e');
  }
}
