import 'package:stats_app/core/interfaces/params/auth_params.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stats_app/features/auth/data/datasources/remote/i_auth_remote_datasource.dart';

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  AuthRemoteDataSource(this._firebaseAuth);

  @override
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

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
  User? getCurrentUser() => _firebaseAuth.currentUser;

  @override
  Future<void> logoutUser() async => await _firebaseAuth.signOut();
}
