import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stats_app/features/auth/data/datasources/local/impl_auth_local_datasource.dart';
import 'package:stats_app/features/auth/data/datasources/remote/impl_auth_remote_datasource.dart';
import 'package:stats_app/features/auth/data/repositories/impl_auth_repository.dart';
import 'package:stats_app/features/auth/domain/use_cases/check_auth_use_case.dart';
import 'package:stats_app/features/auth/domain/use_cases/google_login_use_case.dart';
import 'package:stats_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:stats_app/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:stats_app/features/auth/domain/use_cases/register_use_case.dart';
import 'package:stats_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:stats_app/features/auth/presentation/bloc/auth_event.dart';

class BlocProviders {
  static Future<List<BlocProvider>> getProviders() async {
    final authRepository = ImplAuthRepository(
      AuthRemoteDataSource(FirebaseAuth.instance),
      AuthLocalDataSource(await SharedPreferences.getInstance()),
    );

    return [
      BlocProvider<AuthBloc>(
        create: (context) {
          final authBloc = AuthBloc(
            RegisterUseCase(authRepository),
            LoginUseCase(authRepository),
            CheckAuthUseCase(authRepository),
            LogoutUseCase(authRepository),
            GoogleLoginUseCase(authRepository),
          );
          authBloc.add(CheckAuthEvent());
          return authBloc;
        },
      ),
    ];
  }
}
