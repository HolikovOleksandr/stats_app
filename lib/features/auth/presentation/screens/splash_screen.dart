import 'package:stats_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:stats_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:stats_app/core/routes/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRoutes.data, (route) => false);
        } else if (state is AuthInitial) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
        }
      },
      child: const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
