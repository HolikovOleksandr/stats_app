import 'package:firebase_auth/firebase_auth.dart';
import 'package:stats_app/core/interfaces/params/auth_params.dart';
import 'package:stats_app/features/auth/data/datasources/local/i_auth_local_datasource.dart';
import 'package:stats_app/features/auth/data/datasources/remote/i_auth_remote_datasource.dart';
import 'package:stats_app/features/auth/domain/repositories/i_auth_repository.dart';

class ImplAuthRepository implements IAuthRepository {
  final IAuthRemoteDataSource _remoteDataSource;
  final IAuthLocalDataSource _localDataSource;

  const ImplAuthRepository(this._remoteDataSource, this._localDataSource);

  @override
  Future<UserCredential> loginWithGoogle() async {
    try {
      final userCredential = await _remoteDataSource.signInWithGoogle();

      if (userCredential.user == null) {
        throw Exception("Failed to retrieve user credentials.");
      }

      await _localDataSource.cacheUserEmail(userCredential.user!.email!);
      return userCredential;
    } catch (e) {
      throw Exception("Login with Google failed: $e");
    }
  }

  @override
  Future<UserCredential> registerUser(AuthParams params) async {
    try {
      final userCredential = await _remoteDataSource.registerUser(params);

      if (userCredential.user == null) {
        throw Exception("Failed to retrieve user after registration.");
      }

      await _localDataSource.cacheUserEmail(params.email);
      return userCredential;
    } catch (e) {
      throw Exception("Registration failed: $e");
    }
  }

  @override
  Future<UserCredential> loginUser(AuthParams params) async {
    try {
      final userCredential = await _remoteDataSource.loginUser(params);

      if (userCredential.user == null) {
        throw Exception("Failed to retrieve user after login.");
      }

      await _localDataSource.cacheUserEmail(params.email);
      return userCredential;
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  @override
  Future<User?> checkAuthStatus() async {
    try {
      final currentUser = _remoteDataSource.getCurrentUser();
      final cachedEmail = _localDataSource.getCachedUserEmail();

      if (currentUser != null && currentUser.email == cachedEmail) {
        return currentUser;
      }

      return null;
    } catch (e) {
      throw Exception("Failed to check auth status: $e");
    }
  }

  @override
  Future<void> logoutUser() async {
    try {
      await _remoteDataSource.logoutUser();
      await _localDataSource.clearCachedUser();
    } catch (e) {
      throw Exception("Logout failed: $e");
    }
  }
}
