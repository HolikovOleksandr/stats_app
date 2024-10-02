import 'package:stats_app/features/auth/data/datasources/impl_auth_local_datasource.dart';
import 'package:stats_app/features/auth/data/datasources/impl_auth_remote_datasource.dart';
import 'package:stats_app/features/auth/data/repositories/impl_auth_repository.dart';
import 'package:stats_app/features/auth/domain/use_cases/check_auth_use_case.dart';
import 'package:stats_app/features/auth/domain/use_cases/register_use_case.dart';
import 'package:stats_app/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:stats_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:stats_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:stats_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stats_app/routes/app_routes.dart';
import 'package:stats_app/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) {
                final authRepository = ImplAuthRepository(
                  AuthRemoteDataSource(FirebaseAuth.instance),
                  AuthLocalDataSource(snapshot.data!),
                );

                final authBloc = AuthBloc(
                  RegisterUseCase(authRepository),
                  LoginUseCase(authRepository),
                  CheckAuthUseCase(authRepository),
                  LogoutUseCase(authRepository),
                );

                authBloc.add(CheckAuthEvent());
                return authBloc;
              },
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            onGenerateRoute: AppRoutes.generateRoute,
            // initialRoute: AppRoutes.splash,
          ),
        );
      },
    );
  }
}
