import 'package:flutter/material.dart';
import 'package:stats_app/features/auth/presentation/screens/login_srcreen.dart';
import 'package:stats_app/features/auth/presentation/screens/register_screen.dart';
import 'package:stats_app/features/auth/presentation/screens/splash_screen.dart';
import 'package:stats_app/features/auth/presentation/screens/user_data_screen.dart';

class AppRoutes {
  static const String register = '/register';
  static const String login = '/login';
  static const String data = '/data';
  static const String splash = '/splash';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case data:
        return MaterialPageRoute(builder: (_) => const UserDataScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      default:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
    }
  }
}
