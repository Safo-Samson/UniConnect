import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  String username;
  String course;
  String? imageUrl;
  String residence;
  String? bio;
  String year;
  String country;
  String flag;

  UserProfile({
    required this.username,
    required this.course,
    required this.year,
    required this.residence,
    required this.country,
    required this.flag,
    this.imageUrl,
    this.bio,
  });


  UserProfile.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : username = snapshot.data()['username'] ?? '',
        course = snapshot.data()['course'] ?? '',
        year = snapshot.data()['year'] ?? '',
        residence = snapshot.data()['residence'] ?? '',
        country = snapshot.data()['nationality'] ?? '',
        flag = snapshot.data()['flag'] ?? '',
        imageUrl = snapshot.data()['imageUrl'],
        bio = snapshot.data()['bio'];

}
