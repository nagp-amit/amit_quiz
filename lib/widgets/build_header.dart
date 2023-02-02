import 'package:amit_quiz/config/colors.dart';
import 'package:flutter/material.dart';

class BuildHeader extends StatelessWidget {
  final String title;

  const BuildHeader({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: primaryFontColor,
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    );
  }
}

