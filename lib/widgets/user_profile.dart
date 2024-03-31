import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  String _userId;
  String _username;
  String _course;
  String _year;
  String _residence;
  String _country;
  String _flag;
  String? _imageUrl;
  String? _bio;
  List<dynamic> _requestedUsers;

  UserProfile({
    required List<dynamic> requestedUsers,
    required String userId,
    required String username,
    required String course,
    required String year,
    required String residence,
    required String country,
    required String flag,
    String? imageUrl,
    String? bio,
  })  : _requestedUsers = requestedUsers,
        _userId = userId,
        _username = username,
        _course = course,
        _year = year,
        _residence = residence,
        _country = country,
        _flag = flag,
        _imageUrl = imageUrl,
        _bio = bio;

  // Factory constructor for QueryDocumentSnapshot
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
  // Getters for private fields
  String get getUserId => _userId;
  String get getUsername => _username;
  String get getCourse => _course;
  String get getYear => _year;
  String get getResidence => _residence;
  String get getCountry => _country;
  String get getFlag => _flag;
  String? get getImageUrl => _imageUrl;
  String? get getBio => _bio;
  List<dynamic> get getRequestedUsers => _requestedUsers;



  // Factory constructor for DocumentSnapshot
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
