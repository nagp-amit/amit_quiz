import 'package:flutter/material.dart';

class ErrorStateCard extends StatelessWidget {
  final String errorText;

  const ErrorStateCard({super.key, required this.errorText});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 24),
          Text(errorText, style: const TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
