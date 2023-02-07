import 'package:amit_quiz/model/result_model.dart';

abstract class ResultRepositoryBase {

  Future<void> saveResult(ResultModel result);
  Future<List<ResultModel>> getResults();
}
