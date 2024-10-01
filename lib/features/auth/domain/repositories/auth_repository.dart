import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stats_app/core/interfaces/params/auth_params.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final SharedPreferences _prefs;

  AuthRepository(this._firebaseAuth, this._prefs);

  Future<UserCredential> registerUser(AuthParams params) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );

      await _prefs.setString('email', params.email);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception('Registration failed: ${e.message}');
    }
  }

  Future<UserCredential> loginUser(AuthParams params) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );

      await _prefs.setString('email', params.email);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception('Login failed: ${e.message}');
    }
  }

  Future<User?> checkAuthStatus() async {
    User? currentUser = _firebaseAuth.currentUser;
    String? savedEmail = _prefs.getString('email');

    return (currentUser != null && currentUser.email == savedEmail)
        ? currentUser
        : null;
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    await _prefs.remove('email');
  }
}
