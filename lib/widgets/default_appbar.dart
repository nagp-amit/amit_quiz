
import 'package:amit_quiz/config/colors.dart';
import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? color;
  final Color? backgroundColor;
  final double? elevation;
  final Color? iconColor;
  final BuildContext context;

  const DefaultAppBar({
    Key? key,
    required this.title,
    this.color,
    this.backgroundColor,
    this.elevation,
    this.iconColor,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: iconColor),
      backgroundColor: backgroundColor,
      elevation: elevation,
      bottom: const TabBar(
        indicatorColor: mainColor,
        tabs: [
        Tab(text: "Quiz"),
        Tab(text: "Result"),
      ],)
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
