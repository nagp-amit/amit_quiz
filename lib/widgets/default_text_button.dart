import 'package:flutter/material.dart';

class DefaultTextButton extends StatelessWidget {
  final Color? color;
  final String child;
  final VoidCallback onPressed;
  final FontWeight fontWeight;

  const DefaultTextButton({
    Key? key,
    this.color,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        child,
        style: TextStyle(
          color: color,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
