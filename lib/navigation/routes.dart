import 'package:amit_quiz/ui/quiz/quiz_screen.dart';
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
  static const quiz = '/quiz';

  static Route routes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return _buildRoute(routeSettings, SplashScreen.create);
      case home:
        return _buildRoute(routeSettings, HomeScreen.create);
      case createAccount:
        return _buildRoute(routeSettings, EmailCreate.create);
      case signInEmail:
        return _buildRoute(routeSettings, EmailSignIn.create);
      case quiz:
        return _buildRoute(routeSettings, QuizScreen.create);
      default:
        throw Exception('Route does not exists');
    }
  }

  static MaterialPageRoute _buildRoute(RouteSettings routeSettings, Function build) => MaterialPageRoute(builder: (context) => build(context), settings: routeSettings);
}
