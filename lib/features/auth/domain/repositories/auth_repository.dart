import 'package:firebase_auth/firebase_auth.dart';
import 'package:stats_app/features/auth/domain/models/auth_params.dart';

class AuthRepository {
  final FirebaseAuth firebaseAuth;
  AuthRepository(this.firebaseAuth);

  Future<UserCredential> registerUser(AuthParams params) async {
    try {
      return await firebaseAuth.createUserWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception('Registration failed: ${e.message}');
    }
  }

  Future<UserCredential> loginUser(AuthParams params) async {
    try {
      return await firebaseAuth.signInWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception('Login failed: ${e.message}');
    }
  }
}
