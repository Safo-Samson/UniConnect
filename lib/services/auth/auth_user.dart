import 'package:firebase_auth/firebase_auth.dart';

class AuthUser {
  final bool isEmailVerified;
  final String? email;
  final String id;

  AuthUser({
    required this.isEmailVerified,
    this.email,
    required this.id,
  });

  factory AuthUser.fromFirebase(User user) {
    return AuthUser(
      isEmailVerified: user.emailVerified,
      email: user.email,
      id: user.uid,
    );
  }
}
