import 'package:firebase_auth/firebase_auth.dart';
import 'package:stats_app/core/interfaces/use_case/i_use_case.dart';
import 'package:stats_app/features/auth/domain/repositories/i_auth_repository.dart';

class CheckAuthUseCase implements IUseCase<void, User?> {
  final IAuthRepository _authRepository;
  CheckAuthUseCase(this._authRepository);

  @override
  Future<User?> execute(void input) async {
    return await _authRepository.checkAuthStatus();
  }
}
