import 'package:equatable/equatable.dart';
import 'package:stats_app/features/auth/domain/use_cases/register_use_case.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterEvent extends AuthEvent {
  final RegisterParams params;

  RegisterEvent(this.params);

  @override
  List<Object?> get props => [params];
}
