import 'package:equatable/equatable.dart';
import 'package:stats_app/features/auth/domain/models/auth_params.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterEvent extends AuthEvent {
  final AuthParams params;
  RegisterEvent(this.params);

  @override
  List<Object?> get props => [params];
}

class LoginEvent extends AuthEvent {
  final AuthParams params;
  LoginEvent(this.params);

  @override
  List<Object?> get props => [params];
}
