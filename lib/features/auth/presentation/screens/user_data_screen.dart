import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stats_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:stats_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:stats_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:stats_app/core/routes/app_routes.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  String? token;
  String? email;

  @override
  void initState() {
    super.initState();
    getJwtToken();
    getEmailFromLocalStorage();
  }

  Future<void> getEmailFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => email = prefs.getString('email'));
  }

  Future<void> getJwtToken() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String? idToken = await user.getIdToken();
      setState(() => token = idToken);
      debugPrint("JWT Token: $idToken");
    } else {
      debugPrint("Користувач не авторизований");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Data'),
        leading: IconButton(
          onPressed: () => context.read<AuthBloc>().add(LogoutEvent()),
          icon: const Icon(CupertinoIcons.clear_thick),
        ),
      ),
      body: Center(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const CircularProgressIndicator();
            } else if (state is AuthSuccess) {
              User user = state.user;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Email: ${email ?? 'nothing'}'),
                  Text('UID: ${user.uid}'),
                ],
              );
            } else if (state is AuthFailure) {
              return Text('Помилка: ${state.message}');
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.login,
                  (route) => false,
                );
              });
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
