import 'package:flutter/material.dart';
import 'package:amit_quiz/ui/email_create_screen.dart';
import 'package:amit_quiz/ui/email_signin_screen.dart';
import 'package:amit_quiz/ui/home_screen.dart';
import 'package:amit_quiz/ui/splash_screen.dart';

class Routes {
  static const splash = '/';
  static const intro = '/intro';
  static const createAccount = '/createAccount';
  static const signInEmail = '/signInEmail';
  static const home = '/home';

  static Route routes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return _buildRoute(SplashScreen.create);
      case home:
        return _buildRoute(HomeScreen.create);
      case createAccount:
        return _buildRoute(EmailCreate.create);
      case signInEmail:
        return _buildRoute(EmailSignIn.create);
      default:
        throw Exception('Route does not exists');
    }
  }

  static MaterialPageRoute _buildRoute(Function build) => MaterialPageRoute(builder: (context) => build(context));
}
