import 'package:amit_quiz/navigation/routes.dart';
import 'package:flutter/material.dart';

class QuizAppBar extends StatelessWidget implements PreferredSizeWidget {
  const QuizAppBar({
    Key? key,
    this.title = '',
    this.showActionIcon = false,
    this.leading,
    this.titleWidget,
    this.onMenuActionTap,
  }) : super(key: key);

  final String title;
  final Widget? titleWidget;
  final bool showActionIcon;
  final Widget? leading;
  final VoidCallback? onMenuActionTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25 / 1.2),
          child: Stack(
            children: [
              Positioned.fill(
                child: titleWidget == null
                    ? Center(
                        child: Text(title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white)))
                    : Center(child: titleWidget!),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.home, (Route<dynamic> route) => false);
                      },
                      icon: const Icon(Icons.home, color: Colors.white))
                ],
              ),
            ],
          )),
    );
  }

  @override
  Size get preferredSize => const Size(
        double.maxFinite,
        80,
      );
}
