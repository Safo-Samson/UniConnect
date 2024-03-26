import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  
  String userId;
  String username;
  String course;
  String? imageUrl;
  String residence;
  String? bio;
  String year;
  String country;
  String flag;
  List<dynamic> requestedUsers; 


  UserProfile({
    required this.requestedUsers,
    required this.userId,
    required this.username,
    required this.course,
    required this.year,
    required this.residence,
    required this.country,
    required this.flag,
    this.imageUrl,
    this.bio,
  });

  // Constructor for QueryDocumentSnapshot
  factory UserProfile.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserProfile(
      userId: snapshot.data()['userId'] ?? ' No user ID',
      username: snapshot.data()['username'] ?? '',
      course: snapshot.data()['course'] ?? '',
      year: snapshot.data()['year'] ?? '',
      residence: snapshot.data()['residence'] ?? '',
      country: snapshot.data()['nationality'] ?? '',
      flag: snapshot.data()['flag'] ?? '',
      imageUrl: snapshot.data()['imageUrl'],
      bio: snapshot.data()['bio'],
      requestedUsers: snapshot.data()['requestedUsers'] ?? [],
    );
  }

  // Constructor for DocumentSnapshot
  factory UserProfile.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserProfile(
      userId: snapshot.data()?['userId'] ?? 'No user ID',
      username: snapshot.data()?['username'] ?? '',
      course: snapshot.data()?['course'] ?? '',
      year: snapshot.data()?['year'] ?? '',
      residence: snapshot.data()?['residence'] ?? '',
      country: snapshot.data()?['nationality'] ?? '',
      flag: snapshot.data()?['flag'] ?? '',
      imageUrl: snapshot.data()?['imageUrl'],
      bio: snapshot.data()?['bio'],
      requestedUsers: snapshot.data()?['requestedUsers'] ?? [],
    );
  }
}
