import 'package:flutter/material.dart';

class ContentArea extends StatelessWidget {
  const ContentArea({Key? key, required this.child, this.addPadding = true, })
      : super(key: key);

  final Widget child;
  final bool addPadding;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)) ,
      clipBehavior: Clip.hardEdge,
      type: MaterialType.transparency,
      child: Ink(
        
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 240, 237, 255),
         
        ),
        padding: addPadding
            ? const EdgeInsets.only(
                top: 25.0,
                left: 25.0,
                right: 25.0)
            : EdgeInsets.zero,
        child: child,
      ),
    );
  }
}
