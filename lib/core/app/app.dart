import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stats_app/core/theme/app_theme.dart';
import 'package:stats_app/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:stats_app/core/providers/bloc_providers.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BlocProvider>>(
      future: BlocProviders.getProviders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        return MultiBlocProvider(
          providers: snapshot.data!,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: ThemeMode.system,
            onGenerateRoute: AppRoutes.generateRoute,
          ),
        );
      },
    );
  }
}
