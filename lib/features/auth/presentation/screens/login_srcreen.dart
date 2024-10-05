import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stats_app/core/interfaces/params/auth_params.dart';
import 'package:stats_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:stats_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:stats_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:stats_app/core/routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void inputAdminCreds() {
    setState(() {
      _emailController.text = 'admin@admin.com';
      _passwordController.text = 'adminadmin';
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => inputAdminCreds(),
          icon: const Icon(CupertinoIcons.add),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 64),
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 64),
                  _EmailField(controller: _emailController),
                  const SizedBox(height: 16),
                  _PasswordField(controller: _passwordController),
                  const Spacer(),
                  _LoginButton(
                    emailController: _emailController,
                    passwordController: _passwordController,
                  ),
                  const SizedBox(height: 20),
                  BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      debugPrint("Current AuthState: $state");

                      if (state is AuthSuccess) {
                        Navigator.of(context)
                            .pushReplacementNamed(AppRoutes.data);
                      } else if (state is AuthFailure) {
                        debugPrint("AuthFailure: ${state.message}");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Помилка: ${state.message}')),
                        );
                      }
                    },
                    child: Container(),
                  ),
                  const SizedBox(height: 56),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('First time? '),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRoutes.register, (route) => false);
                        },
                        child: const Text('Register'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailField extends StatelessWidget {
  final TextEditingController controller;
  const _EmailField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(labelText: 'Email'),
      validator: (v) => (v == null || v.isEmpty) ? 'Enter you email' : null,
    );
  }
}

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  const _PasswordField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(labelText: 'Password'),
      obscureText: true,
      validator: (v) => (v == null || v.isEmpty) ? 'Enter you password' : null,
    );
  }
}

class _LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const _LoginButton({
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style,
      onPressed: () {
        if (Form.of(context).validate()) {
          context.read<AuthBloc>().add(LoginEvent(
                AuthParams(
                  email: emailController.text,
                  password: passwordController.text,
                ),
              ));
        }
      },
      child: const Text('Login'),
    );
  }
}
