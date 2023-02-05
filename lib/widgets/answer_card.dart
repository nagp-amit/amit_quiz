import 'package:flutter/material.dart';

enum AnswerStatus { correct, wrong, answered, notanswered }

class AnswerCard extends StatelessWidget {
  const AnswerCard({
    Key? key,
    required this.answer,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  final String answer;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.0),
      onTap: onTap,
      child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).cardColor,
              border: Border.all(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : const Color.fromARGB(255, 221, 221, 221))),
          child: Text(
            answer,
            style: TextStyle(color: isSelected ? Colors.white : null),
          )),
    );
  }
}
