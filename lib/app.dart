import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amit_quiz/cubit/auth_cubit.dart';
import 'package:amit_quiz/navigation/routes.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static Widget create() {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSignedOut) {
          _navigatorKey.currentState?.pushNamedAndRemoveUntil(Routes.signInEmail, (r) => false);
        } else if (state is AuthSignedIn) {
          _navigatorKey.currentState?.pushNamedAndRemoveUntil(Routes.home, (r) => false);
        }
      },
      child: const MyApp(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Authentication Flow',
      onGenerateRoute: Routes.routes,
    );
  }
}
