import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uniconnect/services/auth/auth_exceptions.dart';
import 'package:uniconnect/services/auth/auth_provider.dart';
import 'package:uniconnect/services/auth/auth_user.dart';
import 'package:uniconnect/services/auth/firebase_auth_provider.dart';
import 'package:uniconnect/widgets/user_profile.dart';

class AuthService implements MyAuthProvider {
  final MyAuthProvider provider;

  const AuthService(this.provider);

// to create a firebaseauth instance, because now its the only provider we have
  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<AuthUser> createUser(
      {required String email, required String password}) {
    return provider.createUser(email: email, password: password);
  }

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> login({required String email, required String password}) {
    return provider.login(email: email, password: password);
  }

  @override
  Future<void> sendEmailVerification() {
    return provider.sendEmailVerification();
  }

  @override
  Future<void> signOut() {
    return provider.signOut();
  }

  // Function to get user's nationality
  Future<String> getUserNationality(String userId) async {
    try {
      String userNationality = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get()
          .then((value) => value.data()!['nationality']);

      return userNationality;
    } catch (e) {
      throw CouldNotGetUserNationalityException();
    }
  }

  Future<UserProfile> getCurrentUserProfile() async {
    final currentUser = FirebaseAuthProvider().currentUser;

    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();

    return UserProfile.fromDocumentSnapshot(userData);
  }

  @override
  Future<void> initialize() async {
    return provider.initialize();
  }
}
