import 'package:firebase_auth/firebase_auth.dart';

class AuthUser {
  final bool isEmailVerified;
  final String? email;
  final String uid;

  AuthUser({
    required this.isEmailVerified,
    required this.email,
    required this.uid,
  });

  factory AuthUser.fromFirebase(User user) {
    return AuthUser(
      isEmailVerified: user.emailVerified,
      email: user.email,
      uid: user.uid,
    );
  }
}
