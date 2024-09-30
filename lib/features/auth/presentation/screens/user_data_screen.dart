import 'package:stats_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:stats_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  String? token;

  @override
  void initState() {
    super.initState();
    getJwtToken();
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
      appBar: AppBar(title: const Text('User Data')),
      body: Center(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthSuccess) {
              User user = state.user;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Email: ${user.email}'),
                  Text('UID: ${user.uid}'),
                ],
              );
            } else if (state is AuthFailure) {
              return Text('Помилка: ${state.message}');
            } else {
              return const Text('Користувач не знайдений або не залогінений');
            }
          },
        ),
      ),
    );
  }
}
