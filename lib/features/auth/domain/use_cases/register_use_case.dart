import 'package:firebase_auth/firebase_auth.dart';
import 'package:stats_app/core/use_cases/i_use_case.dart';
import 'package:stats_app/features/auth/domain/models/auth_params.dart';
import 'package:stats_app/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase implements IUseCase<User, AuthParams> {
  final AuthRepository authRepository;
  RegisterUseCase(this.authRepository);

  @override
  Future<User> execute(AuthParams params) async {
    UserCredential userCredential = await authRepository.registerUser(params);
    return userCredential.user!;
  }
}
