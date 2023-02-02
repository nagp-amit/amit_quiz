import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => const SplashScreen();
  

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () => Navigator.of(context).pushReplacementNamed('/signInEmail'));
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 24),
            Text('Loading...', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
