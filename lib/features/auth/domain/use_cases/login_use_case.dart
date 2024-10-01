import 'package:firebase_auth/firebase_auth.dart';
import 'package:stats_app/core/interfaces/params/auth_params.dart';
import 'package:stats_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:stats_app/core/interfaces/use_case/i_use_case.dart';

class LoginUseCase implements IUseCase<User?, AuthParams> {
  final AuthRepository authRepository;
  LoginUseCase(this.authRepository);

  @override
  Future<User?> execute(AuthParams params) async {
    try {
      UserCredential userCredential = await authRepository.loginUser(params);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception('Login failed: ${e.message}');
    }
  }
}
