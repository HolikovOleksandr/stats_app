import 'package:firebase_auth/firebase_auth.dart';
import 'package:stats_app/features/auth/domain/use_cases/register_use_case.dart';

class AuthRepository {
  final FirebaseAuth firebaseAuth;
  AuthRepository(this.firebaseAuth);

  Future<UserCredential> registerUser(RegisterParams params) async {
    return await firebaseAuth.createUserWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}
