import 'package:amit_quiz/data_source/firebase_data_source.dart';
import 'package:amit_quiz/main.dart';
import 'package:amit_quiz/model/question_model.dart';
import 'package:amit_quiz/repository/question_repository.dart';

class QuestionRepository extends QuestionRepositoryBase {
  final FirebaseDataSource _fDataSource = getIt();
  final String collectionName = "questions";

  @override
  Future<List<QuestionModel>> getQuestions(int categoryId) async {
    var result = await _fDataSource.firestore.collection(collectionName).where("categoryId", isEqualTo: categoryId).get();

    List<QuestionModel> questions = [];
    for (var element in result.docs) {
        questions.add(QuestionModel.fromFirebaseMap(element.id, element.data()));
    }
    return questions;
  }
}
