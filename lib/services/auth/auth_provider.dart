import 'package:uniconnect/services/auth/auth_user.dart';

// this class helps to decouple the firebase auth from the rest of the app,
// so that we can easily switch to another auth provider in the future

// called it MyAuthProvider because AuthProvider is already taken by firebase_auth
abstract class MyAuthProvider {
  AuthUser? get currentUser;

  Future<AuthUser> login({
    required String email,
    required String password,
  });

  Future<AuthUser> createUser({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<void> sendEmailVerification();
}
