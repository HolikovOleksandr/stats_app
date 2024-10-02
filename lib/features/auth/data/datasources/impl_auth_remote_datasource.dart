import 'package:stats_app/core/interfaces/params/auth_params.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'interfaces/i_auth_remote_datasource.dart';

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  AuthRemoteDataSource(this._firebaseAuth);

  @override
  Future<UserCredential> registerUser(AuthParams params) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: params.email, password: params.password);
  }

  @override
  Future<UserCredential> loginUser(AuthParams params) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: params.email, password: params.password);
  }

  @override
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<void> logoutUser() async {
    return await _firebaseAuth.signOut();
  }
}
