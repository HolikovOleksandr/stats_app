import 'package:firebase_auth/firebase_auth.dart';
import 'package:stats_app/core/use_cases/i_use_case.dart';
import 'package:stats_app/features/auth/domain/repositories/auth_repository.dart';

class RegisterUserUseCase implements IUseCase<User, RegisterParams> {
  final AuthRepository authRepository;
  RegisterUserUseCase(this.authRepository);

  @override
  Future<User> execute(RegisterParams params) async {
    UserCredential userCredential = await authRepository.registerUser(params);
    return userCredential.user!;
  }
}

class RegisterParams {
  final String email;
  final String password;

  RegisterParams({
    required this.email,
    required this.password,
  });
}
