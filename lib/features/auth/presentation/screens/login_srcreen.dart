import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stats_app/core/interfaces/params/auth_params.dart';
import 'package:stats_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:stats_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:stats_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:stats_app/routes/app_routes.dart';

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
    debugPrint(
      "Admin credentials set: ${_emailController.text}, ${_passwordController.text}",
    );
  }

  @override
  void dispose() {
    debugPrint("Disposing controllers");
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Building LoginScreen");
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
                  Text(
                    'Login',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  _EmailField(controller: _emailController),
                  _PasswordField(controller: _passwordController),
                  const Spacer(),
                  _LoginButton(
                      emailController: _emailController,
                      passwordController: _passwordController),
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
                    child: Container(), // Можна залишити пусту Container
                  ),
                  const SizedBox(height: 56),
                  TextButton(
                    onPressed: () {
                      debugPrint("Navigating to Register screen");
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRoutes.register, (route) => false);
                    },
                    child: const Text('Register'),
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          debugPrint("Email validation failed: empty");
          return 'Введіть електронну пошту';
        }
        debugPrint("Email validated: $value");
        return null;
      },
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          debugPrint("Password validation failed: empty");
          return 'Введіть пароль';
        }
        debugPrint("Password validated");
        return null;
      },
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
      onPressed: () {
        debugPrint("Login button pressed");
        if (Form.of(context).validate()) {
          debugPrint("Form validated, proceeding to login");
          context.read<AuthBloc>().add(
                LoginEvent(
                  AuthParams(
                    email: emailController.text,
                    password: passwordController.text,
                  ),
                ),
              );
        } else {
          debugPrint("Form validation failed");
        }
      },
      child: const Text('Login'),
    );
  }
}
