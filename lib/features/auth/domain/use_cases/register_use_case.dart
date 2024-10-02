import 'package:firebase_auth/firebase_auth.dart';
import 'package:stats_app/core/interfaces/params/auth_params.dart';
import 'package:stats_app/core/interfaces/use_case/i_use_case.dart';
import 'package:stats_app/features/auth/domain/repositories/i_auth_repository.dart';

class RegisterUseCase implements IUseCase<User, AuthParams> {
  final IAuthRepository authRepository;
  RegisterUseCase(this.authRepository);

  @override
  Future<User> execute(AuthParams params) async {
    UserCredential userCredential = await authRepository.registerUser(params);
    return userCredential.user!;
  }
}
