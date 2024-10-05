import 'package:stats_app/core/interfaces/params/auth_params.dart';
import 'package:stats_app/core/routes/app_routes.dart';
import 'package:stats_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:stats_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:stats_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 64),
                Text(
                  'Create Account',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 64),
                _InputFields(
                  emailController: _emailController,
                  passwordController: _passwordController,
                ),
                const Spacer(),
                _SubmitButton(
                  emailController: _emailController,
                  passwordController: _passwordController,
                ),
                const SizedBox(height: 56),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Already have an account? '),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.login);
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InputFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const _InputFields({
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: emailController,
          decoration: const InputDecoration(labelText: 'Email'),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: passwordController,
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const _SubmitButton({
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            context.read<AuthBloc>().add(
                  RegisterEvent(
                    AuthParams(
                      email: emailController.text,
                      password: passwordController.text,
                    ),
                  ),
                );
          },
          child: const Text('Sign up'),
        ),
        const SizedBox(height: 20),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              if (ModalRoute.of(context)?.settings.name != AppRoutes.data) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(AppRoutes.data, (route) => false);
              }
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return const CircularProgressIndicator();
              } else if (state is AuthFailure) {
                return Text('Error: ${state.message}');
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }
}
