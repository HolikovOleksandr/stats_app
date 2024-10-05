import 'package:stats_app/features/auth/data/datasources/interfaces/i_auth_local_datasource.dart';
import 'package:stats_app/features/auth/data/datasources/interfaces/i_auth_remote_datasource.dart';
import 'package:stats_app/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:stats_app/core/interfaces/params/auth_params.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ImplAuthRepository implements IAuthRepository {
  final IAuthRemoteDataSource _remoteDataSource;
  final IAuthLocalDataSource _localDataSource;

  const ImplAuthRepository(this._remoteDataSource, this._localDataSource);

  @override
  Future<UserCredential> registerUser(AuthParams params) async {
    final userCredential = await _remoteDataSource.registerUser(params);
    await _localDataSource.cacheUserEmail(params.email);
    return userCredential;
  }

  @override
  Future<UserCredential> loginUser(AuthParams params) async {
    final userCredential = await _remoteDataSource.loginUser(params);
    await _localDataSource.cacheUserEmail(params.email);
    return userCredential;
  }

  @override
  Future<User?> checkAuthStatus() async {
    User? currentUser = _remoteDataSource.getCurrentUser();
    String? cachedEmail = _localDataSource.getCachedUserEmail();
    return (currentUser!.email == cachedEmail) ? currentUser : null;
  }

  @override
  Future<void> logoutUser() async {
    await _remoteDataSource.logoutUser();
    await _localDataSource.clearCachedUser();
  }
}
