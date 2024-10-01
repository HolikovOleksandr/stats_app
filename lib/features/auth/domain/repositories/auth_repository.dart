import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stats_app/features/auth/domain/models/auth_params.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  AuthRepository(this._firebaseAuth);

  Future<UserCredential> registerUser(AuthParams params) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception('Registration failed: ${e.message}');
    }
  }

  Future<UserCredential> loginUser(AuthParams params) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception('Login failed: ${e.message}');
    }
  }

  Future<User?> checkAuthStatus() async {
    User? currentUser = _firebaseAuth.currentUser;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString('email');

    return (currentUser != null && currentUser.email == savedEmail)
        ? currentUser
        : null;
  }
}
