

import 'dart:core';

import 'package:amit_quiz/model/answer_model.dart';

class QuestionModel {
  final String id;
  final String title;
  final String categoryId;
  final int correctAnsId;
  final List<AnswerModel> answers;

  QuestionModel({
    required this.id, 
    required this.title,
    required this.categoryId,
    required this.correctAnsId,
    required this.answers
  });

   QuestionModel.fromFirebaseMap(this.id, Map<String, Object?> data)
      : title = (data['title'] ?? '').toString(),
        categoryId = (data['categoryId'] ?? '').toString(),
        correctAnsId = int.parse((data['categoryId'] ?? '').toString()),
        answers = (data['answers'] as List).map((e) => AnswerModel.fromFirebaseMap(e)).toList();
}
