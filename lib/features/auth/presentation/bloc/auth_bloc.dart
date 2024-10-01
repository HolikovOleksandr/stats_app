import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stats_app/features/auth/domain/use_cases/check_auth_use_case.dart';
import 'package:stats_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:stats_app/features/auth/domain/use_cases/register_use_case.dart';
import 'package:stats_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:stats_app/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final CheckAuthUseCase checkAuthUseCase;

  AuthBloc(
    this.registerUseCase,
    this.loginUseCase,
    this.checkAuthUseCase,
  ) : super(AuthInitial()) {
    on<RegisterEvent>(_onRegisterEvent);
    on<LoginEvent>(_onLoginEvent);
    on<CheckAuthEvent>(_onCheckAuthEvent);
  }

  Future<void> _onRegisterEvent(
      RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      User user = await registerUseCase.execute(event.params);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', event.params.email);

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      User? user = await loginUseCase.execute(event.params);

      if (user != null) {
        await prefs.setString('email', event.params.email);
        emit(AuthSuccess(user));
      } else {
        emit(AuthFailure('User not found'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onCheckAuthEvent(
      CheckAuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      User? currentUser = await checkAuthUseCase.execute(null);

      currentUser != null
          ? emit(AuthSuccess(currentUser))
          : emit(AuthInitial());
    } catch (e) {
      emit(AuthInitial());
    }
  }
}
