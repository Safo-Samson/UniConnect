import 'package:uniconnect/services/auth/auth_provider.dart';
import 'package:uniconnect/services/auth/auth_user.dart';
import 'package:uniconnect/services/auth/firebase_auth_provider.dart';

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
  
  @override
  Future<void> initialize() async {
    return provider.initialize();
  }

  
}