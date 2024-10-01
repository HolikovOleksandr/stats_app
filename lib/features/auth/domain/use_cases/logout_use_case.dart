import 'package:stats_app/core/interfaces/use_case/i_use_case.dart';
import 'package:stats_app/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase implements IUseCase<void, void> {
  final AuthRepository _authRepository;
  LogoutUseCase(this._authRepository);

  @override
  Future<void> execute(void params) async {
    await _authRepository.logout();
  }
}
