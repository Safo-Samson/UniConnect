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
}
