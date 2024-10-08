import 'package:stats_app/core/interfaces/use_case/i_use_case.dart';
import 'package:stats_app/features/auth/domain/repositories/i_auth_repository.dart';

class GoogleLoginUseCase implements IUseCase {
  final IAuthRepository _authRepository;
  GoogleLoginUseCase(this._authRepository);

  @override
  Future execute(params) async => await _authRepository.loginWithGoogle();
}
