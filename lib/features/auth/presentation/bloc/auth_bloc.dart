import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stats_app/features/auth/domain/use_cases/check_auth_use_case.dart';
import 'package:stats_app/features/auth/domain/use_cases/google_login_use_case.dart';
import 'package:stats_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:stats_app/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:stats_app/features/auth/domain/use_cases/register_use_case.dart';
import 'package:stats_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:stats_app/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final CheckAuthUseCase checkAuthUseCase;
  final LogoutUseCase logoutUseCase;
  final GoogleLoginUseCase googleLoginUseCase;

  AuthBloc(
    this.registerUseCase,
    this.loginUseCase,
    this.checkAuthUseCase,
    this.logoutUseCase,
    this.googleLoginUseCase,
  ) : super(AuthInitial()) {
    on<GoogleLoginEvent>(_onGoogleLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
    on<LoginEvent>(_onLoginEvent);
    on<CheckAuthEvent>(_onCheckAuthEvent);
    on<LogoutEvent>(_onLogoutEvent);
  }

  Future<void> _onGoogleLoginEvent(
      GoogleLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      UserCredential userCredential = await googleLoginUseCase.execute(null);
      emit(AuthSuccess(userCredential.user!));
      debugPrint(emit.toString());
    } catch (e) {
      emit(AuthFailure(e.toString()));
      debugPrint(emit.toString());
    }
  }

  Future<void> _onRegisterEvent(
      RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      User user = await registerUseCase.execute(event.params);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      User? user = await loginUseCase.execute(event.params);
      emit(AuthSuccess(user!));
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

  Future<void> _onLogoutEvent(
      LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await logoutUseCase.execute(null);
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
