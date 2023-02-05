import 'package:amit_quiz/model/question_model.dart';

abstract class QuestionRepositoryBase {

  Future<List<QuestionModel>> getQuestions(int categoryId);
}
