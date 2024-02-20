import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> createSubcollectionForAllDocuments(String collectionName) async {
  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection(collectionName);

  // Get all documents in the collection
  final QuerySnapshot snapshot = await collectionRef.get();

  // Loop through each document and create a 'users' subcollection
  for (final DocumentSnapshot document in snapshot.docs) {
    final DocumentReference docRef = collectionRef.doc(document.id);
    await docRef.collection('users').add({
      // Add any initial data for the users subcollection if needed
    });
  }
}
