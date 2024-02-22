class UserProfile {
  String username;
  String course;
  String? imageUrl;
  String residence;
  String? bio;
  String year;
  String country;

  UserProfile({
    required this.username,
    required this.course,
    required this.year,
    required this.residence,
    required this.country,
    this.imageUrl,
    this.bio,
  });
}
