import 'package:uniconnect/services/auth/auth_user.dart';
import 'package:uniconnect/widgets/user_profile.dart';

// this class helps to decouple the firebase auth from the rest of the app,
// so that I can easily switch to another auth provider in the future

// called it MyAuthProvider because AuthProvider is already taken by firebase_auth
abstract class MyAuthProvider {

  Future<void> initialize();
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

  Future<String> getUserNationality(String userId);

  Future<String> getUserResidence(String userId);

  Future<String> getUserCourse(String userId);

  Future<UserProfile> getCurrentUserProfile();
  
}
