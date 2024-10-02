import 'package:firebase_auth/firebase_auth.dart';
import 'package:stats_app/core/interfaces/params/auth_params.dart';

abstract class IAuthRemoteDataSource {
  Future<UserCredential> registerUser(AuthParams params);
  Future<UserCredential> loginUser(AuthParams params);
  User? getCurrentUser();
  Future<void> logoutUser();
}
