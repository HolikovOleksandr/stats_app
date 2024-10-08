import 'package:firebase_auth/firebase_auth.dart';
import 'package:stats_app/core/interfaces/params/auth_params.dart';

abstract class IAuthRepository {
  Future<UserCredential> loginWithGoogle();

  Future<UserCredential> registerUser(AuthParams params);

  Future<UserCredential> loginUser(AuthParams params);

  Future<User?> checkAuthStatus();

  Future<void> logoutUser();
}
